function tt --description "Time tracker"
    set -l base_dir
    if test -n "$TIME_TRACKER_DIR"
        set base_dir $TIME_TRACKER_DIR
    else
        echo "Error: TIME_TRACKER_DIR is not set"
        echo "Run: set -U TIME_TRACKER_DIR /path/to/your/time-tracking/dir"
        return 1
    end

    mkdir -p $base_dir
    set -l session_file "$base_dir/.active-session"
    set -l subcommand $argv[1]

    if test -z "$subcommand"
        echo "Usage: tt <start|stop|pause|resume|status|report> [args]"
        return 1
    end

    switch $subcommand
        case start
            _tt_start $session_file $argv[2..]
        case stop
            _tt_stop $base_dir $session_file
        case pause
            _tt_pause $session_file
        case resume
            _tt_resume $session_file
        case status
            _tt_status $session_file
        case report
            _tt_report $base_dir $argv[2..]
        case '*'
            echo "Unknown subcommand: $subcommand"
            echo "Usage: tt <start|stop|pause|resume|status|report> [args]"
            return 1
    end
end

function _tt_format_duration --description "Formats seconds into Xh Ymin"
    set -l total_seconds $argv[1]
    set -l hours (math "floor($total_seconds / 3600)")
    set -l minutes (math "floor(($total_seconds % 3600) / 60)")
    set -l seconds (math "$total_seconds % 60")

    if test $hours -gt 0 -a $minutes -gt 0
        printf '%dh %dmin' $hours $minutes
    else if test $hours -gt 0
        printf '%dh' $hours
    else if test $minutes -gt 0
        printf '%dmin' $minutes
    else
        printf '%ds' $seconds
    end
end

function _tt_start --description "Starts a tracked session"
    set -l session_file $argv[1]
    set -l category $argv[2]
    set -l title $argv[3..]

    if test -f $session_file
        set -l start_time (head -1 $session_file)
        set -l existing_category (sed -n '2p' $session_file)
        set -l existing_title (sed -n '3p' $session_file)
        set -l start_hm (date -d "$start_time" +%H:%M)
        set -l msg "Error: Session already running since $start_hm [$existing_category]"
        if test -n "$existing_title"
            set msg "$msg - $existing_title"
        end
        echo $msg
        return 1
    end

    if test -z "$category"
        echo "Error: Category is required"
        echo "Usage: tt start <category> [title]"
        echo "Example: tt start work \"feature X\""
        return 1
    end

    set -l now (date +%Y-%m-%dT%H:%M:%S)
    set -l now_hm (date +%H:%M)

    if test -z "$title"
        set title ""
    else
        set title (string join " " $title)
    end

    printf '%s\n%s\n%s\n%s\n%s\n%s\n' "$now" "$category" "$title" active 0 0 >$session_file

    if test -n "$title"
        echo "Session started at $now_hm [$category] - $title"
    else
        echo "Session started at $now_hm [$category]"
    end
end

function _tt_stop --description "Stops the current session"
    set -l base_dir $argv[1]
    set -l session_file $argv[2]

    if not test -f $session_file
        echo "Error: No active session"
        return 1
    end

    set -l start_time (sed -n '1p' $session_file)
    set -l category (sed -n '2p' $session_file)
    set -l title (sed -n '3p' $session_file)
    set -l state (sed -n '4p' $session_file)
    set -l paused_seconds (sed -n '5p' $session_file)
    set -l pause_count (sed -n '6p' $session_file)

    if test "$state" = paused
        set -l pause_start (sed -n '7p' $session_file)
        set -l pause_start_epoch (date -d "$pause_start" +%s)
        set -l now_epoch (date +%s)
        set paused_seconds (math "$paused_seconds + $now_epoch - $pause_start_epoch")
    end

    set -l start_epoch (date -d "$start_time" +%s)
    set -l end_epoch (date +%s)
    set -l gross_seconds (math "$end_epoch - $start_epoch")
    set -l net_seconds (math "$gross_seconds - $paused_seconds")

    set -l start_hm (date -d "$start_time" +%H:%M)
    set -l end_hm (date +%H:%M)
    set -l net_fmt (_tt_format_duration $net_seconds)
    set -l gross_fmt (_tt_format_duration $gross_seconds)

    if test -z "$title"
        set title -
    end

    set -l start_date (date -d "$start_time" +%Y-%m-%d)
    set -l start_month (date -d "$start_time" +%Y-%m)
    set -l day_dir "$base_dir/$start_month/$start_date"
    set -l cat_file "$day_dir/$category.md"

    mkdir -p $day_dir

    set -l paused_display
    if test "$pause_count" -gt 0
        set -l paused_fmt (_tt_format_duration $paused_seconds)
        set paused_display "$pause_count ($paused_fmt)"
    else
        set paused_display -
    end

    set -l cap_category (string sub -l 1 $category | string upper)(string sub -s 2 $category)
    set -l table_row "| $title | $start_hm | $end_hm | $gross_fmt | $paused_display | $net_fmt |"

    if not test -f $cat_file
        printf '%s\n' \
            "# $cap_category - $start_date" \
            "" \
            "| Title | Start | End | Gross | Pauses | Net |" \
            "|-------|-------|-----|-------|--------|-----|" \
            "$table_row" \
            "" \
            "**Net total: $net_fmt** | Gross total: $gross_fmt | Total pauses: $paused_display" >$cat_file
    else
        sed -i '/^\*\*\(Net\|Total\)/d' $cat_file
        sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' $cat_file
        echo "$table_row" >>$cat_file

        set -l total_net 0
        set -l total_gross 0
        set -l total_pause_count 0
        set -l total_paused_seconds 0
        for line in (grep -E '^\|.*\|.*\| [0-9]{2}:[0-9]{2}' $cat_file)
            set -l g (echo $line | awk -F'|' '{print $5}' | string trim)
            set -l g_s (_tt_parse_duration "$g")
            set total_gross (math "$total_gross + $g_s")

            set -l p (echo $line | awk -F'|' '{print $6}' | string trim)
            if test "$p" != "-"
                set -l p_count (string match -r '(\d+) \(' "$p")
                if test -n "$p_count"
                    set total_pause_count (math "$total_pause_count + $p_count[2]")
                end
                set -l p_dur (string match -r '\((.+)\)' "$p")
                if test -n "$p_dur"
                    set -l p_s (_tt_parse_duration "$p_dur[2]")
                    set total_paused_seconds (math "$total_paused_seconds + $p_s")
                end
            end

            set -l n (echo $line | awk -F'|' '{print $7}' | string trim)
            set -l n_s (_tt_parse_duration "$n")
            set total_net (math "$total_net + $n_s")
        end

        set -l total_net_fmt (_tt_format_duration $total_net)
        set -l total_gross_fmt (_tt_format_duration $total_gross)
        set -l total_pauses_display
        if test "$total_pause_count" -gt 0
            set -l total_paused_fmt (_tt_format_duration $total_paused_seconds)
            set total_pauses_display "Total pauses: $total_pause_count ($total_paused_fmt)"
        else
            set total_pauses_display "Total pauses: -"
        end
        echo "" >>$cat_file
        echo "**Net total: $total_net_fmt** | Gross total: $total_gross_fmt | $total_pauses_display" >>$cat_file
    end

    rm $session_file

    echo "Session ended: $start_hm - $end_hm [$category] (net: $net_fmt | gross: $gross_fmt) - $title"
end

function _tt_parse_duration --description "Converts 'Xh Ymin' to seconds"
    set -l input $argv[1]
    set -l hours 0
    set -l minutes 0
    set -l seconds 0

    set -l h_match (string match -r '(\d+)h' $input)
    if test -n "$h_match"
        set hours $h_match[2]
    end

    set -l m_match (string match -r '(\d+)min' $input)
    if test -n "$m_match"
        set minutes $m_match[2]
    end

    set -l s_match (string match -r '(\d+)s$' $input)
    if test -n "$s_match"
        set seconds $s_match[2]
    end

    math "$hours * 3600 + $minutes * 60 + $seconds"
end

function _tt_pause --description "Pauses the current session"
    set -l session_file $argv[1]

    if not test -f $session_file
        echo "Error: No active session"
        return 1
    end

    set -l state (sed -n '4p' $session_file)
    if test "$state" = paused
        echo "Error: Session is already paused"
        return 1
    end

    set -l start_time (sed -n '1p' $session_file)
    set -l category (sed -n '2p' $session_file)
    set -l title (sed -n '3p' $session_file)
    set -l paused_seconds (sed -n '5p' $session_file)
    set -l pause_count (sed -n '6p' $session_file)
    set pause_count (math "$pause_count + 1")
    set -l now (date +%Y-%m-%dT%H:%M:%S)
    set -l now_hm (date +%H:%M)

    printf '%s\n%s\n%s\n%s\n%s\n%s\n%s\n' "$start_time" "$category" "$title" paused "$paused_seconds" "$pause_count" "$now" >$session_file

    echo "Session paused at $now_hm"
end

function _tt_resume --description "Resumes a paused session"
    set -l session_file $argv[1]

    if not test -f $session_file
        echo "Error: No active session"
        return 1
    end

    set -l state (sed -n '4p' $session_file)
    if test "$state" != paused
        echo "Error: Session is not paused"
        return 1
    end

    set -l start_time (sed -n '1p' $session_file)
    set -l category (sed -n '2p' $session_file)
    set -l title (sed -n '3p' $session_file)
    set -l paused_seconds (sed -n '5p' $session_file)
    set -l pause_count (sed -n '6p' $session_file)
    set -l pause_start (sed -n '7p' $session_file)

    set -l pause_start_epoch (date -d "$pause_start" +%s)
    set -l now_epoch (date +%s)
    set -l this_pause (math "$now_epoch - $pause_start_epoch")
    set paused_seconds (math "$paused_seconds + $this_pause")

    set -l now_hm (date +%H:%M)
    set -l pause_duration (_tt_format_duration $this_pause)

    printf '%s\n%s\n%s\n%s\n%s\n%s\n' "$start_time" "$category" "$title" active "$paused_seconds" "$pause_count" >$session_file

    echo "Session resumed at $now_hm (paused for $pause_duration)"
end

function _tt_status --description "Shows current session status"
    set -l session_file $argv[1]

    if not test -f $session_file
        echo "No active session"
        return 0
    end

    set -l start_time (sed -n '1p' $session_file)
    set -l category (sed -n '2p' $session_file)
    set -l title (sed -n '3p' $session_file)
    set -l state (sed -n '4p' $session_file)
    set -l paused_seconds (sed -n '5p' $session_file)
    set -l pause_count (sed -n '6p' $session_file)

    set -l start_hm (date -d "$start_time" +%H:%M)
    set -l start_epoch (date -d "$start_time" +%s)
    set -l now_epoch (date +%s)
    set -l gross_seconds (math "$now_epoch - $start_epoch")

    set -l total_paused $paused_seconds
    if test "$state" = paused
        set -l pause_start (sed -n '7p' $session_file)
        set -l pause_start_epoch (date -d "$pause_start" +%s)
        set total_paused (math "$total_paused + $now_epoch - $pause_start_epoch")
    end

    set -l net_seconds (math "$gross_seconds - $total_paused")
    set -l gross_fmt (_tt_format_duration $gross_seconds)
    set -l net_fmt (_tt_format_duration $net_seconds)

    set -l state_label
    if test "$state" = paused
        set state_label PAUSED
    else
        set state_label ACTIVE
    end

    echo "[$state_label] Session started at $start_hm [$category]"
    if test -n "$title"
        echo "Title: $title"
    end
    echo "Net time: $net_fmt | Gross time: $gross_fmt"
    if test "$pause_count" -gt 0
        set -l paused_fmt (_tt_format_duration $total_paused)
        echo "Pauses: $pause_count ($paused_fmt)"
    end
end

function _tt_report --description "Shows daily report"
    set -l base_dir $argv[1]
    set -l category $argv[2]
    set -l target_date $argv[3]

    if test -z "$target_date"
        set target_date (date +%Y-%m-%d)
    end

    set -l target_month (string sub -l 7 $target_date)
    set -l day_dir "$base_dir/$target_month/$target_date"

    if not test -d $day_dir
        echo "No records for $target_date"
        return 0
    end

    if test -n "$category"
        set -l cat_file "$day_dir/$category.md"
        if not test -f $cat_file
            echo "No records for $target_date [$category]"
            return 0
        end
        cat $cat_file
    else
        for f in $day_dir/*.md
            cat $f
            echo ""
        end
    end
end

