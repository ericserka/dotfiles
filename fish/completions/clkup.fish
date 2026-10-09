# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_clickup_cli_global_optspecs
    string join \n token= workspace= output= fields= no-header all limit= page= cursor= q/quiet timeout= h/help V/version
end

function __fish_clickup_cli_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_clickup_cli_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_clickup_cli_using_subcommand
    set -l cmd (__fish_clickup_cli_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c clkup -n "__fish_clickup_cli_needs_command" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_needs_command" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_needs_command" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_needs_command" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_needs_command" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_needs_command" -s V -l version -d 'Print version'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "setup" -d 'Configure API token and default workspace'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "auth" -d 'Authentication commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "workspace" -d 'Workspace commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "space" -d 'Space commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "folder" -d 'Folder commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "list" -d 'List commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "task" -d 'Task commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "checklist" -d 'Checklist commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "comment" -d 'Comment commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "tag" -d 'Tag commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "field" -d 'Custom field commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "task-type" -d 'Custom task type commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "attachment" -d 'Attachment commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "time" -d 'Time tracking commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "goal" -d 'Goal commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "view" -d 'View commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "member" -d 'Member commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "user" -d 'User commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "chat" -d 'Chat commands (v3)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "doc" -d 'Doc commands (v3)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "webhook" -d 'Webhook commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "template" -d 'Template commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "guest" -d 'Guest commands (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "group" -d 'Group commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "role" -d 'Role commands (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "shared" -d 'Shared hierarchy commands'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "audit-log" -d 'Audit log commands (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "acl" -d 'ACL commands (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "agent-config" -d 'Generate CLI reference for AI agent configs'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "mcp" -d 'Start MCP server (Model Context Protocol over stdio)'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "status" -d 'Show current configuration and status'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "completions" -d 'Generate shell completions'
complete -c clkup -n "__fish_clickup_cli_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l token -d 'API token (skip interactive prompt)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand setup" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -f -a "whoami" -d 'Show current user info'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -f -a "check" -d 'Quick token validation (exit code only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and not __fish_seen_subcommand_from whoami check help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from whoami" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from check" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "whoami" -d 'Show current user info'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "check" -d 'Quick token validation (exit code only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -f -a "list" -d 'List workspaces'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -f -a "seats" -d 'Show seat usage'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -f -a "plan" -d 'Show current plan'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and not __fish_seen_subcommand_from list seats plan help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from seats" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from plan" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from help" -f -a "list" -d 'List workspaces'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from help" -f -a "seats" -d 'Show seat usage'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from help" -f -a "plan" -d 'Show current plan'
complete -c clkup -n "__fish_clickup_cli_using_subcommand workspace; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "list" -d 'List spaces in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "get" -d 'Get space details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "create" -d 'Create a new space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "update" -d 'Update a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "delete" -d 'Delete a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and not __fish_seen_subcommand_from list get create update delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l archived -d 'Include archived spaces'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l name -d 'Space name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l private -d 'Make space private'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l multiple-assignees -d 'Allow multiple assignees'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l color -d 'Color hex' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "list" -d 'List spaces in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get space details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand space; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "list" -d 'List folders in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "get" -d 'Get folder details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "create" -d 'Create a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "update" -d 'Update a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "delete" -d 'Delete a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and not __fish_seen_subcommand_from list get create update delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l archived -d 'Include archived'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l name -d 'Folder name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "list" -d 'List folders in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get folder details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand folder; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "list" -d 'List lists in a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "get" -d 'Get list details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "create" -d 'Create a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "update" -d 'Update a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "delete" -d 'Delete a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "add-task" -d 'Add a task to this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "remove-task" -d 'Remove a task from this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and not __fish_seen_subcommand_from list get create update delete add-task remove-task help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l folder -d 'Folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l space -d 'Space ID (folderless lists)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l archived -d 'Include archived'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l folder -d 'Folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l space -d 'Space ID (folderless)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l name -d 'List name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l content -d 'List content/description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l priority -d 'Priority (1-4)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l due-date -d 'Due date (YYYY-MM-DD)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l content -d 'New content (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from add-task" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from remove-task" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "list" -d 'List lists in a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get list details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "add-task" -d 'Add a task to this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "remove-task" -d 'Remove a task from this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand list; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "list" -d 'List tasks in a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "search" -d 'Search tasks across workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "get" -d 'Get task details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "create" -d 'Create a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "update" -d 'Update a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "delete" -d 'Delete a task (explicit ID required — never auto-detects from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "time-in-status" -d 'Get time in status for task(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "add-tag" -d 'Add a tag to a task. Usage: add-tag <task_id> <tag_name>  OR  add-tag <tag_name> (task auto-detected from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "remove-tag" -d 'Remove a tag from a task. Usage: remove-tag <task_id> <tag_name>  OR  remove-tag <tag_name> (task auto-detected)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "add-dep" -d 'Add a dependency to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "remove-dep" -d 'Remove a dependency from a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "link" -d 'Link two tasks together'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "unlink" -d 'Unlink two tasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "move" -d 'Move a task to a different list (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "set-estimate" -d 'Set time estimate on a task (v2 task-level or v3 per-user)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "replace-estimates" -d 'Replace all per-user time estimates on a task (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and not __fish_seen_subcommand_from list search get create update delete time-in-status add-tag remove-tag add-dep remove-dep link unlink move set-estimate replace-estimates help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l status -d 'Filter by status' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l assignee -d 'Filter by assignee' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l tag -d 'Filter by tag' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l order-by -d 'Order by field' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l include-closed -d 'Include closed tasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l subtasks -d 'Include subtasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l reverse -d 'Reverse sort order'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l space -d 'Filter by space' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l folder -d 'Filter by folder' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l list -d 'Filter by list' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l status -d 'Filter by status' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l assignee -d 'Filter by assignee' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l tag -d 'Filter by tag' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l include-closed -d 'Include closed tasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l subtasks -d 'Include subtasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l subtasks -d 'Include subtasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l custom-task-id -d 'Treat ID as custom task ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l markdown -d 'Include the raw `markdown_description` (preserves inline link URLs that the flattened `description`/`text_content` fields drop)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l name -d 'Task name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l description -d 'Description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l status -d 'Status' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l priority -d 'Priority (1=urgent, 2=high, 3=normal, 4=low)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l assignee -d 'Assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l tag -d 'Tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l due-date -d 'Due date (YYYY-MM-DD)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l parent -d 'Parent task ID (creates subtask)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l status -d 'New status' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l priority -d 'New priority (1-4)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l add-assignee -d 'Add assignee' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l rem-assignee -d 'Remove assignee' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l description -d 'New description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l time-estimate -d 'New time estimate in milliseconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l parent -d 'Re-parent: parent task ID (converts this task into a subtask, or moves it between parents)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from time-in-status" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-tag" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-tag" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l depends-on -d 'This task depends on another task (task is a blocker)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l dependency-of -d 'This task is a dependency of another task (task is blocked by)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from add-dep" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l depends-on -d 'Remove depends-on relationship with this task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l dependency-of -d 'Remove dependency-of relationship with this task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from remove-dep" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from link" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from unlink" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l list -d 'Destination list ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from move" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l assignee -d 'Assignee user ID (v3 per-user estimate). Omit for v2 task-level estimate' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l time -d 'Time estimate in milliseconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l id -d 'Task ID (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from set-estimate" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l estimate -d 'Per-user estimate in the form ASSIGNEE:MS (repeat for each user). ASSIGNEE is a numeric user ID or the literal string `unassigned`. At least one --estimate is required unless --body is provided. This REPLACES the full set of per-user estimates on the task; any user not listed here is removed' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l body -d 'Raw JSON body (overrides --estimate). Must be an array of {assignee, time} objects per ClickUp\'s spec' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l id -d 'Task ID (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from replace-estimates" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "list" -d 'List tasks in a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search tasks across workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get task details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a task (explicit ID required — never auto-detects from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "time-in-status" -d 'Get time in status for task(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "add-tag" -d 'Add a tag to a task. Usage: add-tag <task_id> <tag_name>  OR  add-tag <tag_name> (task auto-detected from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "remove-tag" -d 'Remove a tag from a task. Usage: remove-tag <task_id> <tag_name>  OR  remove-tag <tag_name> (task auto-detected)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "add-dep" -d 'Add a dependency to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "remove-dep" -d 'Remove a dependency from a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "link" -d 'Link two tasks together'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "unlink" -d 'Unlink two tasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "move" -d 'Move a task to a different list (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "set-estimate" -d 'Set time estimate on a task (v2 task-level or v3 per-user)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "replace-estimates" -d 'Replace all per-user time estimates on a task (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "create" -d 'Create a checklist on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "update" -d 'Update a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "delete" -d 'Delete a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "add-item" -d 'Add an item to a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "update-item" -d 'Update a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "delete-item" -d 'Delete a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and not __fish_seen_subcommand_from create update delete add-item update-item delete-item help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l name -d 'Checklist name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l task -d 'Task ID (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l position -d 'Position' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l name -d 'Item name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l assignee -d 'Assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from add-item" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l assignee -d 'Assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l parent -d 'Parent item ID (nest under another item)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l resolved -d 'Mark as resolved'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from update-item" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from delete-item" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a checklist on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "add-item" -d 'Add an item to a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "update-item" -d 'Update a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "delete-item" -d 'Delete a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand checklist; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "list" -d 'List comments on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "create" -d 'Create a comment on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "update" -d 'Update a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "delete" -d 'Delete a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "replies" -d 'List threaded replies on a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "reply" -d 'Reply to a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and not __fish_seen_subcommand_from list create update delete replies reply help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l task -d 'Task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l view -d 'View ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l start -d 'Boundary timestamp in Unix ms for continuing a listing. Pair with --start-id' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l start-id -d 'Boundary comment id for continuing a listing. Pair with --start' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l task -d 'Task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l view -d 'View ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l text -d 'Comment text (use @path to read from a file, @- for stdin, @@ for a literal leading @). Note: ClickUp\'s v2 comment API does not render markdown; markdown syntax is stored as literal text unless --markdown is set' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l assignee -d 'Assignee user ID (task comments only)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l notify-all -d 'Notify all watchers (task comments only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l markdown -d 'Parse --text as markdown and submit ClickUp rich formatting (bold/italic/code/links, lists, code blocks; headings render bold, blockquotes indent, tables/strikethrough degrade to text)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l text -d 'New comment text (use @path to read from a file, @- for stdin, @@ for a literal leading @). Note: ClickUp\'s v2 comment API does not render markdown; markdown syntax is stored as literal text unless --markdown is set' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l assignee -d 'Assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l resolved -d 'Mark as resolved'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l markdown -d 'Parse --text as markdown and submit ClickUp rich formatting (bold/italic/code/links, lists, code blocks; headings render bold, blockquotes indent, tables/strikethrough degrade to text)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l start -d 'Boundary timestamp in Unix ms for continuing a listing. Pair with --start-id' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l start-id -d 'Boundary comment id for continuing a listing. Pair with --start' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from replies" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l text -d 'Reply text (use @path to read from a file, @- for stdin, @@ for a literal leading @). Note: ClickUp\'s v2 comment API does not render markdown; markdown syntax is stored as literal text unless --markdown is set' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l assignee -d 'Assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l markdown -d 'Parse --text as markdown and submit ClickUp rich formatting (bold/italic/code/links, lists, code blocks; headings render bold, blockquotes indent, tables/strikethrough degrade to text)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from reply" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "list" -d 'List comments on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a comment on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "replies" -d 'List threaded replies on a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "reply" -d 'Reply to a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand comment; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -f -a "list" -d 'List tags in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -f -a "create" -d 'Create a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -f -a "update" -d 'Update a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -f -a "delete" -d 'Delete a tag from a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and not __fish_seen_subcommand_from list create update delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l name -d 'Tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l fg-color -d 'Foreground color (hex)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l bg-color -d 'Background color (hex)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l tag -d 'Tag name (current)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l name -d 'New tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l fg-color -d 'New foreground color (hex)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l bg-color -d 'New background color (hex)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l tag -d 'Tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "list" -d 'List tags in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a tag from a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -f -a "list" -d 'List custom fields'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -f -a "set" -d 'Set a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -f -a "unset" -d 'Unset (clear) a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and not __fish_seen_subcommand_from list set unset help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l folder -d 'Folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l workspace-level -d 'Workspace-level fields'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l value -d 'Field value (string, number, or JSON; use the option ID for drop_down fields)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from unset" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from help" -f -a "list" -d 'List custom fields'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from help" -f -a "set" -d 'Set a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from help" -f -a "unset" -d 'Unset (clear) a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand field; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'List custom task types in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from help" -f -a "list" -d 'List custom task types in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand task-type; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -f -a "upload" -d 'Upload a file attachment to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -f -a "list" -d 'List attachments on a task (extracted from the Get Task response)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and not __fish_seen_subcommand_from upload list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l task -d 'Task ID (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from upload" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l task -d 'Task ID (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from help" -f -a "upload" -d 'Upload a file attachment to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from help" -f -a "list" -d 'List attachments on a task (extracted from the Get Task response)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand attachment; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "list" -d 'List time entries'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "get" -d 'Get a time entry by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "current" -d 'Get the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "create" -d 'Create a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "update" -d 'Update a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "delete" -d 'Delete a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "start" -d 'Start a timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "stop" -d 'Stop the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "tags" -d 'List time entry tags for workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "add-tags" -d 'Add tags to a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "remove-tags" -d 'Remove tags from a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "rename-tag" -d 'Rename a time entry tag'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "history" -d 'Get history for a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and not __fish_seen_subcommand_from list get current create update delete start stop tags add-tags remove-tags rename-tag history help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l start-date -d 'Filter by start date (ISO 8601 or Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l end-date -d 'Filter by end date (ISO 8601 or Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l assignee -d 'Filter by assignee user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l task -d 'Filter by task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from current" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l start -d 'Start time (Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l duration -d 'Duration in milliseconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l task -d 'Task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l description -d 'Description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l billable -d 'Mark as billable'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l start -d 'New start time (Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l end -d 'New end time (Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l description -d 'New description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l billable -d 'Mark as billable' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l task -d 'Task ID to associate with the timer' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l description -d 'Description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l billable -d 'Mark as billable'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from stop" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from tags" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l entry-id -d 'Time entry ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l tag -d 'Tag name(s) to add' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from add-tags" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l entry-id -d 'Time entry ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l tag -d 'Tag name(s) to remove' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from remove-tags" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l name -d 'Current tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l new-name -d 'New tag name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l tag-bg -d 'New background colour as a hex string (required by ClickUp\'s spec, e.g. #000000)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l tag-fg -d 'New foreground colour as a hex string (required by ClickUp\'s spec, e.g. #FFFFFF)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from rename-tag" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "list" -d 'List time entries'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a time entry by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "current" -d 'Get the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start a timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "stop" -d 'Stop the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "tags" -d 'List time entry tags for workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "add-tags" -d 'Add tags to a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "remove-tags" -d 'Remove tags from a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "rename-tag" -d 'Rename a time entry tag'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "history" -d 'Get history for a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand time; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "list" -d 'List goals in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "get" -d 'Get a goal by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "create" -d 'Create a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "update" -d 'Update a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "delete" -d 'Delete a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "add-kr" -d 'Add a key result to a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "update-kr" -d 'Update a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "delete-kr" -d 'Delete a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and not __fish_seen_subcommand_from list get create update delete add-kr update-kr delete-kr help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l include-completed -d 'Include completed goals'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l name -d 'Goal name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l due-date -d 'Due date (Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l description -d 'Description' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l color -d 'Color hex (e.g. #32a852)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l owner -d 'Owner user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l due-date -d 'New due date (Unix ms)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l description -d 'New description (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l color -d 'New color hex' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l add-owner -d 'Add owner by user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l rem-owner -d 'Remove owner by user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l name -d 'Key result name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l kr-type -d 'Type: number, currency, boolean, percentage, automatic' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l steps-start -d 'Starting step value' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l steps-end -d 'Target step value' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l unit -d 'Unit label (e.g. "tasks")' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l owner -d 'Owner user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from add-kr" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l steps-current -d 'Current step value' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l note -d 'Note' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from update-kr" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from delete-kr" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "list" -d 'List goals in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a goal by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "add-kr" -d 'Add a key result to a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "update-kr" -d 'Update a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "delete-kr" -d 'Delete a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand goal; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "list" -d 'List views (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "get" -d 'Get a view by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "create" -d 'Create a view (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "update" -d 'Update a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "delete" -d 'Delete a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "tasks" -d 'List tasks in a view. Honours global --all/--page/--limit for pagination'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and not __fish_seen_subcommand_from list get create update delete tasks help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l folder -d 'Folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l workspace-level -d 'List workspace-level views'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l name -d 'View name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l view-type -d 'View type (list, board, calendar, gantt, activity, map, workload, table, doc, chat, embed)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l folder -d 'Folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l workspace-level -d 'Create workspace-level view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from tasks" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "list" -d 'List views (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a view by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a view (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "tasks" -d 'List tasks in a view. Honours global --all/--page/--limit for pagination'
complete -c clkup -n "__fish_clickup_cli_using_subcommand view; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'List members of a task or list (use --task or --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l task -d 'Task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l list -d 'List ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from help" -f -a "list" -d 'List members of a task or list (use --task or --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand member; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -f -a "invite" -d 'Invite a user to the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -f -a "get" -d 'Get a workspace member by user ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -f -a "update" -d 'Update a workspace member'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -f -a "remove" -d 'Remove a user from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and not __fish_seen_subcommand_from invite get update remove help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l email -d 'Email address' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l custom-role-id -d 'Custom role ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l admin -d 'Grant admin role'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from invite" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l username -d 'New username' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l admin -d 'Set admin role' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l custom-role-id -d 'Custom role ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "invite" -d 'Invite a user to the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a workspace member by user ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a workspace member'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove a user from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-list" -d 'List channels in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-create" -d 'Create a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-get" -d 'Get a channel by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-update" -d 'Update a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-delete" -d 'Delete a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-followers" -d 'List followers of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "channel-members" -d 'List members of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "dm" -d 'Create or get a direct message channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "message-list" -d 'List messages in a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "message-send" -d 'Send a message to a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "message-update" -d 'Update a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "message-delete" -d 'Delete a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "reaction-list" -d 'List reactions on a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "reaction-add" -d 'Add a reaction to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "reaction-remove" -d 'Remove a reaction from a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "reply-list" -d 'List replies to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "reply-send" -d 'Send a reply to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "tagged-users" -d 'Get users tagged in a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and not __fish_seen_subcommand_from channel-list channel-create channel-get channel-update channel-delete channel-followers channel-members dm message-list message-send message-update message-delete reaction-list reaction-add reaction-remove reply-list reply-send tagged-users help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l include-closed -d 'Include closed channels'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l name -d 'Channel name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l visibility -d 'Visibility: PUBLIC or PRIVATE' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l name -d 'New name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l topic -d 'New topic' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-followers" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from channel-members" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from dm" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l channel -d 'Channel ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l channel -d 'Channel ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l text -d 'Message text (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l type -d 'Message type: message or post' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-send" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l text -d 'New message text (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from message-delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l emoji -d 'Emoji name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-add" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reaction-remove" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l text -d 'Reply text (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from reply-send" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from tagged-users" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-list" -d 'List channels in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-create" -d 'Create a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-get" -d 'Get a channel by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-update" -d 'Update a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-delete" -d 'Delete a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-followers" -d 'List followers of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "channel-members" -d 'List members of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "dm" -d 'Create or get a direct message channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "message-list" -d 'List messages in a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "message-send" -d 'Send a message to a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "message-update" -d 'Update a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "message-delete" -d 'Delete a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "reaction-list" -d 'List reactions on a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "reaction-add" -d 'Add a reaction to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "reaction-remove" -d 'Remove a reaction from a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "reply-list" -d 'List replies to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "reply-send" -d 'Send a reply to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "tagged-users" -d 'Get users tagged in a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand chat; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "list" -d 'List docs in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "create" -d 'Create a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "get" -d 'Get a doc by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "pages" -d 'List pages in a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "add-page" -d 'Add a page to a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "page" -d 'Get a specific page from a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "edit-page" -d 'Edit a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "embed-image" -d 'Upload an image and embed it inline in a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and not __fish_seen_subcommand_from list create get pages add-page page edit-page embed-image help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l creator -d 'Filter by creator user ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l archived -d 'Include archived docs'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l name -d 'Doc name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l visibility -d 'Visibility: PUBLIC, PRIVATE, or PERSONAL' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l parent-type -d 'Parent type: SPACE, FOLDER, LIST, EVERYTHING, or WORKSPACE' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l parent-id -d 'Parent ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l max-depth -d 'Maximum page depth' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l content -d 'Include page content'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from pages" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l name -d 'Page name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l parent-page -d 'Parent page ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l content -d 'Page content (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from add-page" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from page" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l content -d 'Page content (use @path to read from a file, @- for stdin, @@ for a literal leading @)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l mode -d 'Content edit mode: replace, append, or prepend' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from edit-page" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l via-task -d 'Host task that stores the image binary (auto-detected from git branch if omitted)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l alt -d 'Alt text for the image (defaults to the file name)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l mode -d 'Where to insert the image relative to existing content' -r -f -a "append\t''
prepend\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from embed-image" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "list" -d 'List docs in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a doc by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "pages" -d 'List pages in a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "add-page" -d 'Add a page to a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "page" -d 'Get a specific page from a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "edit-page" -d 'Edit a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "embed-image" -d 'Upload an image and embed it inline in a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand doc; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -f -a "list" -d 'List webhooks for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -f -a "create" -d 'Create a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -f -a "update" -d 'Update a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -f -a "delete" -d 'Delete a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and not __fish_seen_subcommand_from list create update delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l endpoint -d 'Endpoint URL' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l event -d 'Event(s) to subscribe to (can be repeated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l space -d 'Scope to a specific space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l folder -d 'Scope to a specific folder ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l list -d 'Scope to a specific list ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l task -d 'Scope to a specific task ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l endpoint -d 'New endpoint URL' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l event -d 'Event(s) to subscribe to (can be repeated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l status -d 'Webhook status: active or inactive' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from help" -f -a "list" -d 'List webhooks for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand webhook; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -f -a "list" -d 'List task templates for the workspace. Honours global --all/--page/--limit'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -f -a "apply-task" -d 'Apply a task template to a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -f -a "apply-list" -d 'Apply a list template to a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -f -a "apply-folder" -d 'Apply a folder template to a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and not __fish_seen_subcommand_from list apply-task apply-list apply-folder help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l list -d 'List ID to create the task in' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l name -d 'Task name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-task" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l folder -d 'Folder ID (mutually exclusive with --space)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l space -d 'Space ID (mutually exclusive with --folder)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l name -d 'List name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l space -d 'Space ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l name -d 'Folder name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from apply-folder" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from help" -f -a "list" -d 'List task templates for the workspace. Honours global --all/--page/--limit'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from help" -f -a "apply-task" -d 'Apply a task template to a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from help" -f -a "apply-list" -d 'Apply a list template to a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from help" -f -a "apply-folder" -d 'Apply a folder template to a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand template; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "invite" -d 'Invite a guest to the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "get" -d 'Get a guest by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "update" -d 'Update guest permissions'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "remove" -d 'Remove a guest from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "share-task" -d 'Share a task with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "unshare-task" -d 'Unshare a task from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "share-list" -d 'Share a list with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "unshare-list" -d 'Unshare a list from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "share-folder" -d 'Share a folder with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "unshare-folder" -d 'Unshare a folder from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and not __fish_seen_subcommand_from invite get update remove share-task unshare-task share-list unshare-list share-folder unshare-folder help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l email -d 'Guest email address' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l custom-role-id -d 'Custom role ID to assign' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l can-edit-tags -d 'Allow guest to edit tags'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l can-see-time-spent -d 'Allow guest to see time spent'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l can-create-views -d 'Allow guest to create views'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from invite" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from get" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l can-edit-tags -d 'Allow guest to edit tags' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l can-see-time-spent -d 'Allow guest to see time spent' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l can-create-views -d 'Allow guest to create views' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l custom-role-id -d 'Custom role ID to assign' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l permission -d 'Permission level: read, comment, edit, create' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-task" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-task" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l permission -d 'Permission level: read, comment, edit, create' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l permission -d 'Permission level: read, comment, edit, create' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from share-folder" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from unshare-folder" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "invite" -d 'Invite a guest to the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "get" -d 'Get a guest by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update guest permissions'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove a guest from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "share-task" -d 'Share a task with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "unshare-task" -d 'Unshare a task from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "share-list" -d 'Share a list with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "unshare-list" -d 'Unshare a list from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "share-folder" -d 'Share a folder with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "unshare-folder" -d 'Unshare a folder from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand guest; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -f -a "list" -d 'List groups in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -f -a "create" -d 'Create a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -f -a "update" -d 'Update a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -f -a "delete" -d 'Delete a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and not __fish_seen_subcommand_from list create update delete help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l name -d 'Group name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l member -d 'Member user IDs (repeat for multiple)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l name -d 'New group name' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l add-member -d 'User IDs to add (repeat for multiple)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l rem-member -d 'User IDs to remove (repeat for multiple)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "list" -d 'List groups in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand group; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'List custom roles in the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from help" -f -a "list" -d 'List custom roles in the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand role; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -f -a "list" -d 'List shared hierarchy (tasks, lists, folders) for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and not __fish_seen_subcommand_from list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from help" -f -a "list" -d 'List shared hierarchy (tasks, lists, folders) for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand shared; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -f -a "query" -d 'Query audit logs (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and not __fish_seen_subcommand_from query help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l applicability -d 'Required scope of the query. ClickUp\'s documented values: WORKSPACE, TEAMS, USERS' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l event-type -d 'Filter by event type (e.g. AUTH, HIERARCHY, USER, CUSTOM_FIELDS, AGENT, OTHER)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l event-status -d 'Filter by event status (e.g. SUCCESS, FAILURE)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l user-id -d 'Filter by user ID (repeat for multiple)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l user-email -d 'Filter by user email (repeat for multiple)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l start-time -d 'Start time (Unix timestamp in milliseconds), maps to filter.startTime' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l end-time -d 'End time (Unix timestamp in milliseconds), maps to filter.endTime' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l page-rows -d 'Max rows per page (pagination.pageRows)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l page-timestamp -d 'Cursor timestamp (pagination.pageTimestamp)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l page-direction -d 'Page direction (pagination.pageDirection): NEXT or PREVIOUS' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from query" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from help" -f -a "query" -d 'Query audit logs (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand audit-log; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -f -a "update" -d 'Update ACL for an object (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and not __fish_seen_subcommand_from update help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l private -d 'Mark the object private (true) or remove the private flag (false). Omit to leave unchanged' -r -f -a "true\t''
false\t''"
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l grant-user -d 'Grant a user permission. Format: USER_ID[:LEVEL] where LEVEL is read|comment|edit|create (default: read). Repeat for multiple users' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l grant-group -d 'Grant a group permission. Same format as --grant-user but the id refers to a user group' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l revoke-user -d 'Revoke a user (sends permission_level=0). Repeat for multiple users' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l revoke-group -d 'Revoke a group (sends permission_level=0). Repeat for multiple groups' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l body -d 'Raw JSON body (overrides all other flags). Use this for advanced shapes the flags don\'t cover' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update ACL for an object (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand acl; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -f -a "show" -d 'Print compressed CLI reference for AI agent instruction files'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -f -a "inject" -d 'Inject CLI reference into a file (auto-detects or creates agent instruction file)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -f -a "init" -d 'Initialize project-level ClickUp config (.clickup.toml and/or .mcp.json)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and not __fish_seen_subcommand_from show inject init help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from inject" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l token -d 'API token' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l workspace -d 'Workspace ID' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l mcp -d 'Also create .mcp.json for MCP server integration'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from init" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from help" -f -a "show" -d 'Print compressed CLI reference for AI agent instruction files'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from help" -f -a "inject" -d 'Inject CLI reference into a file (auto-detects or creates agent instruction file)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from help" -f -a "init" -d 'Initialize project-level ClickUp config (.clickup.toml and/or .mcp.json)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand agent-config; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -f -a "serve" -d 'Start the MCP server (reads JSON-RPC from stdin, writes to stdout)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and not __fish_seen_subcommand_from serve help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l profile -d 'Preset tool bundle: `all` (default), `read`, `safe`' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l groups -d 'Include only tools in these resource groups (comma-separated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l exclude-groups -d 'Drop tools in these resource groups (comma-separated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l tools -d 'Include only these tools by exact name (comma-separated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l exclude-tools -d 'Drop these tools by exact name (comma-separated)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l read-only -d 'Shortcut for `--profile read`'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from serve" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from help" -f -a "serve" -d 'Start the MCP server (reads JSON-RPC from stdin, writes to stdout)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand mcp; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand status" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l token -d 'API token (overrides config file)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l workspace -d 'Workspace ID (overrides config default)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l output -d 'Output format: table, json, json-compact, csv' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l fields -d 'Comma-separated list of fields to display' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l limit -d 'Cap total results' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l page -d 'Manual page selection (v2 page-based endpoints)' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l cursor -d 'Opaque cursor from a previous response (v3 cursor-based endpoints). Use with chat-* and doc list commands' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l timeout -d 'HTTP timeout in seconds' -r
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l no-header -d 'Omit table header row'
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -l all -d 'Fetch all pages'
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -s q -l quiet -d 'Only print IDs, one per line'
complete -c clkup -n "__fish_clickup_cli_using_subcommand completions" -s h -l help -d 'Print help'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "setup" -d 'Configure API token and default workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "auth" -d 'Authentication commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "workspace" -d 'Workspace commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "space" -d 'Space commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "folder" -d 'Folder commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "list" -d 'List commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "task" -d 'Task commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "checklist" -d 'Checklist commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "comment" -d 'Comment commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "tag" -d 'Tag commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "field" -d 'Custom field commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "task-type" -d 'Custom task type commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "attachment" -d 'Attachment commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "time" -d 'Time tracking commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "goal" -d 'Goal commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "view" -d 'View commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "member" -d 'Member commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "user" -d 'User commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "chat" -d 'Chat commands (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "doc" -d 'Doc commands (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "webhook" -d 'Webhook commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "template" -d 'Template commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "guest" -d 'Guest commands (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "group" -d 'Group commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "role" -d 'Role commands (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "shared" -d 'Shared hierarchy commands'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "audit-log" -d 'Audit log commands (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "acl" -d 'ACL commands (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "agent-config" -d 'Generate CLI reference for AI agent configs'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "mcp" -d 'Start MCP server (Model Context Protocol over stdio)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "status" -d 'Show current configuration and status'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "completions" -d 'Generate shell completions'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and not __fish_seen_subcommand_from setup auth workspace space folder list task checklist comment tag field task-type attachment time goal view member user chat doc webhook template guest group role shared audit-log acl agent-config mcp status completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "whoami" -d 'Show current user info'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "check" -d 'Quick token validation (exit code only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from workspace" -f -a "list" -d 'List workspaces'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from workspace" -f -a "seats" -d 'Show seat usage'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from workspace" -f -a "plan" -d 'Show current plan'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from space" -f -a "list" -d 'List spaces in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from space" -f -a "get" -d 'Get space details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from space" -f -a "create" -d 'Create a new space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from space" -f -a "update" -d 'Update a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from space" -f -a "delete" -d 'Delete a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from folder" -f -a "list" -d 'List folders in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from folder" -f -a "get" -d 'Get folder details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from folder" -f -a "create" -d 'Create a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from folder" -f -a "update" -d 'Update a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from folder" -f -a "delete" -d 'Delete a folder'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "list" -d 'List lists in a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "get" -d 'Get list details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "create" -d 'Create a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "update" -d 'Update a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "delete" -d 'Delete a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "add-task" -d 'Add a task to this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from list" -f -a "remove-task" -d 'Remove a task from this list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "list" -d 'List tasks in a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "search" -d 'Search tasks across workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "get" -d 'Get task details'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "create" -d 'Create a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "update" -d 'Update a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "delete" -d 'Delete a task (explicit ID required — never auto-detects from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "time-in-status" -d 'Get time in status for task(s)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "add-tag" -d 'Add a tag to a task. Usage: add-tag <task_id> <tag_name>  OR  add-tag <tag_name> (task auto-detected from branch)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "remove-tag" -d 'Remove a tag from a task. Usage: remove-tag <task_id> <tag_name>  OR  remove-tag <tag_name> (task auto-detected)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "add-dep" -d 'Add a dependency to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "remove-dep" -d 'Remove a dependency from a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "link" -d 'Link two tasks together'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "unlink" -d 'Unlink two tasks'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "move" -d 'Move a task to a different list (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "set-estimate" -d 'Set time estimate on a task (v2 task-level or v3 per-user)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task" -f -a "replace-estimates" -d 'Replace all per-user time estimates on a task (v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "create" -d 'Create a checklist on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "update" -d 'Update a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "delete" -d 'Delete a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "add-item" -d 'Add an item to a checklist'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "update-item" -d 'Update a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from checklist" -f -a "delete-item" -d 'Delete a checklist item'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "list" -d 'List comments on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "create" -d 'Create a comment on a task, list, or view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "update" -d 'Update a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "delete" -d 'Delete a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "replies" -d 'List threaded replies on a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from comment" -f -a "reply" -d 'Reply to a comment'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "list" -d 'List tags in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "create" -d 'Create a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "update" -d 'Update a tag in a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "delete" -d 'Delete a tag from a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from field" -f -a "list" -d 'List custom fields'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from field" -f -a "set" -d 'Set a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from field" -f -a "unset" -d 'Unset (clear) a custom field value on a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from task-type" -f -a "list" -d 'List custom task types in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from attachment" -f -a "upload" -d 'Upload a file attachment to a task'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from attachment" -f -a "list" -d 'List attachments on a task (extracted from the Get Task response)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "list" -d 'List time entries'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "get" -d 'Get a time entry by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "current" -d 'Get the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "create" -d 'Create a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "update" -d 'Update a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "delete" -d 'Delete a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "start" -d 'Start a timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "stop" -d 'Stop the currently running timer'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "tags" -d 'List time entry tags for workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "add-tags" -d 'Add tags to a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "remove-tags" -d 'Remove tags from a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "rename-tag" -d 'Rename a time entry tag'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from time" -f -a "history" -d 'Get history for a time entry'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "list" -d 'List goals in workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "get" -d 'Get a goal by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "create" -d 'Create a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "update" -d 'Update a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "delete" -d 'Delete a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "add-kr" -d 'Add a key result to a goal'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "update-kr" -d 'Update a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from goal" -f -a "delete-kr" -d 'Delete a key result'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "list" -d 'List views (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "get" -d 'Get a view by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "create" -d 'Create a view (use one scope flag: --workspace-level, --space, --folder, --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "update" -d 'Update a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "delete" -d 'Delete a view'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from view" -f -a "tasks" -d 'List tasks in a view. Honours global --all/--page/--limit for pagination'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from member" -f -a "list" -d 'List members of a task or list (use --task or --list)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "invite" -d 'Invite a user to the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "get" -d 'Get a workspace member by user ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "update" -d 'Update a workspace member'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "remove" -d 'Remove a user from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-list" -d 'List channels in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-create" -d 'Create a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-get" -d 'Get a channel by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-update" -d 'Update a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-delete" -d 'Delete a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-followers" -d 'List followers of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "channel-members" -d 'List members of a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "dm" -d 'Create or get a direct message channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "message-list" -d 'List messages in a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "message-send" -d 'Send a message to a channel'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "message-update" -d 'Update a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "message-delete" -d 'Delete a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "reaction-list" -d 'List reactions on a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "reaction-add" -d 'Add a reaction to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "reaction-remove" -d 'Remove a reaction from a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "reply-list" -d 'List replies to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "reply-send" -d 'Send a reply to a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from chat" -f -a "tagged-users" -d 'Get users tagged in a message'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "list" -d 'List docs in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "create" -d 'Create a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "get" -d 'Get a doc by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "pages" -d 'List pages in a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "add-page" -d 'Add a page to a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "page" -d 'Get a specific page from a doc'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "edit-page" -d 'Edit a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from doc" -f -a "embed-image" -d 'Upload an image and embed it inline in a doc page'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from webhook" -f -a "list" -d 'List webhooks for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from webhook" -f -a "create" -d 'Create a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from webhook" -f -a "update" -d 'Update a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from webhook" -f -a "delete" -d 'Delete a webhook'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from template" -f -a "list" -d 'List task templates for the workspace. Honours global --all/--page/--limit'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from template" -f -a "apply-task" -d 'Apply a task template to a list'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from template" -f -a "apply-list" -d 'Apply a list template to a folder or space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from template" -f -a "apply-folder" -d 'Apply a folder template to a space'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "invite" -d 'Invite a guest to the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "get" -d 'Get a guest by ID'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "update" -d 'Update guest permissions'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "remove" -d 'Remove a guest from the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "share-task" -d 'Share a task with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "unshare-task" -d 'Unshare a task from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "share-list" -d 'Share a list with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "unshare-list" -d 'Unshare a list from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "share-folder" -d 'Share a folder with a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from guest" -f -a "unshare-folder" -d 'Unshare a folder from a guest'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "list" -d 'List groups in the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "create" -d 'Create a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "update" -d 'Update a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from group" -f -a "delete" -d 'Delete a group'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from role" -f -a "list" -d 'List custom roles in the workspace (Enterprise only)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from shared" -f -a "list" -d 'List shared hierarchy (tasks, lists, folders) for the workspace'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from audit-log" -f -a "query" -d 'Query audit logs (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from acl" -f -a "update" -d 'Update ACL for an object (Enterprise only, v3)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from agent-config" -f -a "show" -d 'Print compressed CLI reference for AI agent instruction files'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from agent-config" -f -a "inject" -d 'Inject CLI reference into a file (auto-detects or creates agent instruction file)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from agent-config" -f -a "init" -d 'Initialize project-level ClickUp config (.clickup.toml and/or .mcp.json)'
complete -c clkup -n "__fish_clickup_cli_using_subcommand help; and __fish_seen_subcommand_from mcp" -f -a "serve" -d 'Start the MCP server (reads JSON-RPC from stdin, writes to stdout)'
