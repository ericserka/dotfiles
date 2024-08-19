# Vim/Nvim Cheat Sheet

This cheat sheet has remaps specific to my configuration, but it also has several native vim/nvim shortcuts.

## The Basics

### Normal mode

The Normal mode is the default mode when launching Vim. It is the one you'll spend the most time using as it allows you to navigate the text, copy/cut/paste characters, words and lines, but also roll-back actions, and so on.

- With `vim.opt.clipboard= "unnamedplus"`, `y` copies to the system-wide clipboard and `p` pastes whatever is in the system-wide clipboard. This option is good for when you work on "multi platforms"
- `$ (shift 4)` moves the cursor to the end of the line
- `0` moves the cursor to the beginning of the line
- `gg` moves the cursor to the beginning of the file
- `G (shift g)` moves the cursor to the end of the file
- `h` moves the cursor to the left
- `j` moves the cursor down
- `k` moves the cursor up
- `l` moves the cursor to the right
- `u` undoes the last change
- `CTRL-r` redoes the last change
- `dw` deletes (cuts) the word from the cursor to the end of it
- `diw` deletes the word under the cursor
- `db` deletes the word from the cursor to the beginning of it
- `dd` deletes (cuts) the entire line
- `x` deletes (cuts) the character under the cursor
- `ciw` changes the word under the cursor (deletes it and enters insert mode)
- `yiw` copies the word under the cursor 
- `w` moves the cursor to the beginning of the next word
- `e` moves the cursor to the end of the current word
- `b` moves the cursor to the beginning of the current word
- `ge` moves the cursor to the end of the previous word
- `a or i` enters insert mode after or before the cursor, respectively
- `yy` copies the entire line
- `p` pastes the content of the clipboard after the cursor
- `P (shift p)` pastes the content of the clipboard before the cursor
- `v` enters visual mode
- `V (shift v)` enters visual line mode (selects entire line under the cursor)
- `CTRL-d` scrolls down half a page
- `CTRL-u` scrolls up half a page
- `CTRL-b` scrolls up one page
- `CTRL-f` scrolls down one page
- `: (shift ;)` enters command mode
- The "Leader key" is a way of extending the power of VIM's shortcuts by using sequences of keys to perform a command. The default leader key is backslash (`\`). It can be used in remaps as `<Leader>` or `<leader>`. In my configuration, the leader key is `" "` (space bar).
- `ZQ` closes the current file without saving
- `ZZ` saves the current file and closes it
- `>>` indent (move right) line one shiftwidth
- `<<` de-indent (move left) line one shiftwidth
- `==` auto-indent current line
- `* (shift 8)` searches for the word under the cursor
- `^` moves the cursor to the first non-blank character of the line
- `{` jump to previous paragraph (previous blank line)
- `}` jump to next paragraph (next blank line)
- `I (shift i)` moves the cursor to the beginning of the line and enters insert mode
- `A (shift a)` moves the cursor to the end of the line and enters insert mode
- `O (shift o)` creates a new line above the current one and enters insert mode
- `o` creates a new line below the current one and enters insert mode
- `s` deletes the character under the cursor and enters insert mode
- `S (shift s) or cc` deletes the entire line and enters insert mode
- `C (shift c)` deletes the character from the cursor to the end of the line and enters insert mode
- `d0i` deletes the text from the cursor to the beginning of the line and enters insert mode
- `ciw` changes the word under the cursor (deletes it and enters insert mode)
- `ci<character>` changes the text inside the `<character>` (e.g. `ci"` changes the text inside the quotes)
- `yiw` copies the word under the cursor
- `yi<character>` copies the text inside the `<character>` (e.g. `yi"` copies the text inside the quotes)
- `diw` deletes the word under the cursor
- `di<character>` deletes the text inside the `<character>` (e.g. `di"` deletes the text inside the quotes)
- `ca<character>` changes the text inside the `<character>` and the `<character>` (e.g. `ca"` changes the text inside the quotes and the quotes)
- `da<character>` deletes the text inside the `<character>` and the `<character>` (e.g. `da"` deletes the text inside the quotes and the quotes)
- `ya<character>` copies the text inside the `<character>` and the `<character>` (e.g. `ya"` copies the text inside the quotes and the quotes)

### Visual mode

The Visual mode allows you to visually highlight (select) specific text areas and run commands on them.

- `d or x` deletes the selected text
- `y` copies the selected text
- `s or c` deletes the selected text and enters insert mode
- `h` moves the cursor to the left
- `j` moves the cursor down
- `k` moves the cursor up
- `l` moves the cursor to the right

### Command mode

The Command-line mode offers a more advanced way of executing commands that are cumbersome or impossible to perform through the Normal mode. For example searching and replacing, or saving and quitting.

- `:vs` (vertical split): splits the window vertically
- `:sp` (split): splits the window horizontally
- `:w` saves the current file
- `:q` closes the current file (it fails if there are unsaved changes)
- `:q!` closes the current file discarding any unsaved changes
- `:wq or :x` saves the current file and closes it
- `:wqa` save and quit on all tabs
- `:qa` quit on all tabs
- `:qa!` quit on all tabs discarding any unsaved changes
- `:h keyword` open help for keyword. This keyword can be an option or a command, for example.
- `:n` go to line `n` of the current file
- Vim automatically appends the visual selection range `'<,'>` for any command when you select an area and enter `:`

#### Search and replace

Vim provides the `:s` (substitute) command for search and replace.

- `:s/foo/bar/g` find each occurrence of 'foo' (in the current line only) and replace it with 'bar'
- `:%s/foo/bar/g` find each occurrence of 'foo' (in all lines) and replace it with 'bar'
- `:%s/foo/bar/gc` find each occurrence of 'foo' (in all lines) and replace it with 'bar', but ask
for confirmation first
- `:%s/\<foo\>/bar/gc` change only whole words exactly matching 'foo' to 'bar'; ask for confirmation
- `:5,12s/foo/bar/g` change each 'foo' to 'bar' for all lines from line 5 to line 12 (inclusive)
- `:'<,'>s/foo/bar/g` change each 'foo' to 'bar' for all lines within a visual selection
- `:%s/foo/bar/` on each line, replace the first occurrence of "foo" with "bar".
- Save typing by using `\zs` and `\ze` to set the start and end of a pattern. For example, instead
of: `:s/Copyright 2007 All Rights Reserved/Copyright 2008 All Rights Reserved/` use `:s/Copyright \zs2007\ze All Rights Reserved/2008/`
- `:%s/.*\zsfoo/bar/` on each line, replace the last occurrence of "foo" with "bar".
- `:%s/\<foo\>//g` on each line, delete all occurrences of the whole word "foo".
- `:%s/\<foo\>.*//` on each line, delete the whole word "foo" and all following text (to end of line).
- `:%s/\<foo\>.\{5}//` on each line, delete the first occurrence of the whole word "foo" and the following five characters. The `\` is not required on the closing `}` so `:%s/\<foo\>.\{5\}//` will do the same thing
- `:%s/\<foo\>\zs.*//` on each line, delete all text following the whole word "foo" (to end of line).
- `:%s/.*\<foo\>//` on each line, delete the whole word "foo" and all preceding text (from beginning of line).
- `:%s/.*\ze\<foo\>//` on each line, delete all the text preceding the whole word "foo" (from beginning of line).
- `\(foo\)` makes a backreference to foo. Parenthesis without escapes are literally matched. Here the `\` is required for the closing `\)`
- When replacing:
    - `\1` inserts the text of the first backreference. `\2` inserts the second backreference, and so on.
- `:%s/.*\(\<foo\>\).*/\1/` on each line, delete all the text preceding and following the whole word "foo".
- Positive lookahead: is used to ensure that a specific pattern is followed by another pattern. In Vim, it is represented by `\@=`. For example, `/foo\(bar\)\@=/` find the word foo that is followed by bar.
- Negative lookahead: is used to ensure that a specific pattern is not followed by another pattern. In Vim, it is represented by `\@!`. For example, `/foo\(bar\)\@!/` find the word foo that is not followed by bar.
- Positive lookbehind: is used to ensure that a specific pattern is preceded by another pattern. In Vim, it is represented by `\@<=`. For example, `/\(foo\)\@<=bar/` find the word bar that is preceded by foo.
- Negative lookbehind: is used to ensure that a specific pattern is not preceded by another pattern. In Vim, it is represented by `\@<!`. For example, `/\(foo\)\@<!bar/` find the word bar that is not preceded by foo.
- `:%s/\<foo\(bar\)\@!/toto/g` on each line, replace each occurrence of "foo" (which starts a word and is not followed by "bar") by "toto".
- When using the `c` flag, you need to confirm for each match what to do. You can choose between:
    - `y` to replace the match
    - `n` to skip the match
    - `a` to replace all matches
    - `q` to quit the command
    - `l` to replace the current match and quit the command
- `<leader>tr` is a remap for `:%s///g` and opens the command line with the search and replace command
- To search in vim, just type `/` and then the word you want to search
- To move between occurrences, press `n` (next) or `N` (prev)
- To search for the word under the cursor, press `*` 
- Examples of search:
    - `/\cword` case insensitive search without matching the entire word (that is, `word_world` would also appear as a result) (equivalent to /word)
    - `/\Cword` case sensitive search without matching the entire word
    - `/\<word\>` search for `word` matching the entire word (that is, `word_world` would not appear as a result)
    - `/\C\<word\>` case sensitive search matching the entire word (i.e., `Word` would not appear as a result)
- `:noh` removes highlight from matches from last search
- `<leader>cs` is a remap for `:noh`

### Insert mode

The Insert mode is the one you should be the most familiar with. It allows you to modify the text buffer by typing and removing characters, the same way you would do in most modern text editors.

- `CTRL-n` insert (auto-complete) next match before the cursor during insert mode
- `CTRL-p` insert (auto-complete) previous match before the cursor during insert mode
- `CTRL-SHIFT-v` paste from the system clipboard
- `CTRL-o` enters normal mode for one command and then returns to insert mode
- `CTRL-w` deletes the word before the cursor
- `CTRL-u` deletes the entire line
- `CTRL-DEL` is a remap for `<C-o>dw` and deletes a word from the beginning to the end

## Installing plugins and creating your own configurations

Vim's native options can be configured/changed and, in addition, many plugins are also configurable programmatically. The default way to change a Vim option in Lua is as follows: `vim.opt.optionname = optionvalue`

In case you need to call a vimscript function inside a lua file, just do: `vim.fn.function_name(args)`.

Recommended to use the lua programming language, although I think there are other options. The following step by step is just a convention followed by me, it is not a "must do".

1. inside the folder `~/.config/nvim/`, create a file called `init.lua` with the require of all lua files (plugins or own) created
2. inside the `~/.config/nvim/lua` folder, create your own lua configuration files
3. inside the `~/.config/nvim/lua/plugins` folder, create lua plugin configuration files
    1. If the plugin doesn't need additional configuration, just put your require inside the `_other-plugin-requires.lua` file

## Plugins

### toggleterm

A neovim lua plugin to help easily manage multiple terminal windows.

- `CTRL-\` opens a terminal
    - inside open terminal: `CTRL-d` switches between normal and insert mode
- My elixir terminal actions:
    - `<leader>tt` runs tests in the line where the cursor is
    - `<leader>tf` runs tests in current file
    - `<leader>tp` runs entire project tests
    - `<leader>pc` runs pre-commit checks

### spectre

A search panel for neovim.

- `<leader>ps`: searches for terms in the project and makes replacements across the entire project
- `?` shows all mappings available
- `ti` (toggle ignore): ignores or not the case of the word to be searched/replaced. When the case is being ignored, an `[I]` appears on the screen; when it is not being ignored, nothing appears
- `th` (toggle hidden): whether or not to show hidden files. When the search for hidden files is activated, an `[H]` appears on the screen; when it is not activated, no. Hidden files are generally those that:
    - start with "."
    - are inside a folder that starts with "."
    - are in `.gitignore`
- `tu` (toggle update): activates or deactivates the live update of the search. With this option enabled, if you change a file and add new text that matches your search, the search will update in real time. When it is disabled, you will have to manually search again.
- `Enter (<CR> - Carriage Return)` enters the selected file (and line)
- `Tab` and `SHIFT-Tab` navigate between search, replace and path options
- `dd` toggle a search item (makes it lighter or darker in order to signal whether you have passed by that item or not)
- `<leader>rc` (replace current): replaces the current word (a done appears next to it to signal that the replacement has been made)
- `<leader>SHIFT-r`: replaces all search words (a done appears next to signal that the replacement has already been made)
- `<leader>rd`: deletes the entire line of all search occurrences
- `<leader>v`: changes the way the results are presented. We have 3 options:
    1. shows the current text and the text that will be replaced at the same time
    2. only shows the text that will be replaced
    3. only shows the current text
- You can use regex in searches, not just plain texts
- Uses [ripgrep](https://github.com/BurntSushi/ripgrep) to do the searches and [sed](https://www.gnu.org/software/sed/) to do the replacements
- It is possible to search within specific directories. Example: `lib/**` searches only within the lib folder. It uses the [glob pattern](https://en.wikipedia.org/wiki/Glob_(programming)). File extension searches also work. Example: `*.ex` only searches files with the `.ex` extension.

### telescope

A highly customizable fuzzy finder over lists. It can be used to find, filter, preview and pick.

- `<leader>fs` file search
- `leader>ws` search for words in the project
- `leader fo` open file history
- `<leader>b` lists open buffers
- You can use regex in searches, not just plain text
- `CTRL-x` enter the selected file in horizontal split mode
- `CTRL-v` enter the selected file in vertical split mode
- `CTRL-u` go up to the preview file
- `CTRL-d` go down to the preview file
- `Ctrl-/` shows all mappings available in insert mode
- `CTRL-p or <Up>` navigates up the file list in insert mode
- `CTRL-n or <Down>` navigates down the file list in insert mode
- `j/k` navigates up/down the file list in normal mode
- `<CR>` enters the selected file
- `<Esc>` enters normal mode
- `?` shows all mappings available in normal mode

### fugitive

A Git wrapper for Vim.

- Basically every git command can be executed using `:Git` or `:G` as a prefix. Examples: `:Git blame`, `:G push`.
- `<leader>gx`: equivalent to `:Git restore .` (discards all changes)
- `<leader>pl`: equivalent to `:Git pull`
- `<leader>ph`: equivalent to `:Git push`
- `<leader>gs`: equivalent to `:Git`. Opens a summary window with dirty files and unpushed and unpulled commits. Inside this window:
    - `<CR>` opens the file
    - `dv` see the file diff with a vertical separation
    - `dd` see the file diff with a horizontal separation
    - `s` stage the file
    - `u` unstage the file
    - `-` it's a toggle (either goes back to unstaged or puts it to staged, depending on the current state)
    - `U` unstage all files
    - `X` discard selected file changes
    - `co<Space>` populates the command line with `:Git checkout`
    - `c<Space>` populates the command line with `:Git commit`
    - `cr<Space>` populates the command line with `:Git revert`
    - `cm<Space>` populates the command line with `:Git merge`
    - `cc` creates a new commit (opens a file so you can put the commit message)
    - `gq` or `:q` closes the window
- `<leader>gb`: equivalent to `:Git blame`. Inside the blame window:
    - `A` resize the window to the end of the author's name
    - `C` resize the window to the end of the commit hash
    - `D` resize the window to the end of the date
    - `-` reblame according to the commit. It's useful when you want to see what the file's state was like after committing. And you can see what the commit changed too, compared to the previous version (last commit in relation to the "reblamed" commit).
    - `gq` or `:q` closes the window
- `dl` and `dh`: choose hunk when merging conflicting files (`dh` left diff and `dl` right diff)
    
### gitsigns

Git decorations/integration for buffers.

- `<leader>hp` shows the diff on the line where the cursor is (inline diff)
- `<leader>hb` shows the blame of the line the cursor is on


### nvim-lspconfig

A collection of common configurations for the Nvim LSP client.

- `:LspInfo` shows the status of active and configured language servers
- `gd` or `CTRL-LeftMouse` goes to the definition of the word under the cursor
- `K` shows the documentation of the word under the cursor (hover)
- `CTRL-x` shows error diagnostics
    
### Mason

Easily install and manage LSP servers, DAP servers, linters, and formatters.

- `:Mason` opens the language servers installation UI (`i` installs certain ls).

### commentary

A plugin that allows you to comment out code easily.

- `gcc` comments the selected piece of code or the entire line if nothing is selected

### tree

A file explorer tree for neovim.

- `a` add a new file or folder (file must end with extension and folder must end with `/`)
- `c` copy a file or folder
- `d` delete a file or folder
- `D` move file or folder to trash
- `p` paste a file or folder
- `r` rename a file or folder
- `x` cuts a file or folder
- `y` copies file or folder name
- `P` moves to the parent directory
- `W` collapse (close all the trees)
- `Y` copies the relative path
- `gy` copies the absolute path
- `g?` shows all mappings available

### markdown-preview

A markdown previewer for neovim.

- `<leader>m` executes the command `:MarkdownPreviewToggle`, that is, opens (or closes) the markdown preview

### csvlens

A plugin that allows you to view CSV files through [csvlens](https://github.com/YS-L/csvlens).

- `<leader>c` executes the command `:Csvlens`, that is, opens the csv view

## Reproducing vscode Features

## CTRL-d

This vscode shortcut allows you to select several common terms and make the necessary changes. Step by step to reproduce in nvim:

1. Search for the desired term
2. With the cursor over the word you want to replace, press the `cgn` keys and type whatever you want
3. To continue replacing, press `.` to repeat the last substitution (`.` is used to repeat the last command executed)

## CTRL-SHIFT-DOWN

This shortcut in vscode is used to change multiple lines simultaneously (multi-cursor).

1. Move the cursor to the first line you want to change
2. Enter visual block mode: `CTRL-v`
3. Navigate down using the `j` key
4. When you reach the last line you want to change, press `I`. `I`, within visual block mode, tells Vim to switch to insertion mode before the first line of the block.
5. Make the necessary changes
6. Exit insert mode (Esc)
