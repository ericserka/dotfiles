# Qutebrowser Cheat Sheet

## The Basics

- Similar to vim/nvim, everything here is case sensitive. So when a shortcut is capitalized, it will probably require you to press shift first.
- The `count` function in quetebrowser works in the Vim style — you type the number before the
command. For example, `3j` will move the cursor down three lines.

## Mute tab
- To mute the current tab, you can use the shortcut `Alt+m` (command `:tab-mute`). To unmute, simply use the same shortcut again.
- To mute a specific tab, first type the index of the tab you want to mute, followed by `Alt+m`. For example, if you want to mute the second tab, you would type `2` followed by `Alt+m`.
- When a tab is emitting sound, the following "icon" appears before its index: `[A]`. When it is muted, the icon that appears is `[M]`.

## Accessing urls quickly

- We basically have 2 ways to quickly access URLs: bookmarks and quickmarks.
- The shortcut `Sq` (command `:bookmark-list`) lists all saved bookmarks and quickmarks. This is one way to quickly access URLs. You can run the command `:bookmark-list -t` if you want to open the list in a new tab.
- In the bookmarks and quickmarks sections below, there are specific ways to access each one. However, a very practical way to access both is using the command `:open` (shortcut `o`) or `:open -t` (shortcut `O`). Just start typing something and the qutebrowser will automatically search the bookmarks and quickmarks in the URL bar suggestions.

### Bookmarks

- Bookmarks are favorite URLs that you save to access later because you use them frequently.
- All your bookmarks are stored in the file `~/.config/qutebrowser/bookmarks/urls`.
- To save the bookmark of the current page, use the shortcut `M`. If you want to save the bookmark of a specific URL, use the command `:bookmark-add [url] [title]`.
- To open a bookmark, you can use the shortcut `gb` (command `:bookmark-load`) or the shortcut `gB` (command `:bookmark-load -t` - new tab)

### Quickmarks

- Quickmarks associate a short name with a URL. They are named shortcuts. A little different from bookmarks.
- All quickmarks are stored in the file `~/.config/qutebrowser/quickmarks`.
- To save the quickmark of the current page, use the shortcut `m` (command `:quickmark-save`). If you want to save the quickmark for a specific URL, use the command `:quickmark-add [url] [name]`.
- To open a quickmark, you can use the shortcut `b` (command `:quickmark-load`) or the shortcut `B` (command `:quickmark-load -t` - new tab).
