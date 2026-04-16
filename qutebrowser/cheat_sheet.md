# Qutebrowser Cheat Sheet

## The Basics

- Similar to vim/nvim, everything here is case sensitive. So when a shortcut is capitalized, it will probably require you to press shift first.
- The `count` function in qutebrowser works in the Vim style — you type the number before the command. For example, `3j` will move the cursor down three lines.
- To see the full list of active bindings (including the defaults and any customizations), run `:open qute://bindings` (use `:open -t qute://bindings` to open it in a new tab). This is the source of truth whenever you forget a shortcut.

## Tabs

### Mute tab
- To mute the current tab, you can use the shortcut `Alt+m` (command `:tab-mute`). To unmute, simply use the same shortcut again.
- To mute a specific tab, first type the index of the tab you want to mute, followed by `Alt+m`. For example, if you want to mute the second tab, you would type `2` followed by `Alt+m`.
- When a tab is emitting sound, the following "icon" appears before its index: `[A]`. When it is muted, the icon that appears is `[M]`.

### Reordering tabs
- `gJ` (command `:tab-move +`) moves the current tab one position to the right.
- `gK` (command `:tab-move -`) moves the current tab one position to the left.
- Both commands accept a count, so `3gJ` moves the current tab three positions to the right.

## Hints

- Hints are qutebrowser's way of interacting with the page without the mouse. When you trigger a hint command, each targetable element on the page receives a short label; typing that label activates the element.
- The hint command accepts a **group** (which elements to label, e.g. `all`, `links`, `images`, `inputs`) and a **target** (what to do with the chosen element, e.g. open in the current tab, in a new background/foreground tab, yank the URL, etc.).
- Defaults you will use the most:
  - `f` (command `:hint`) — labels every clickable element and opens the chosen one in the current tab.
  - `F` (command `:hint all tab`) — same as above, but opens the chosen element in a new background tab.
  - `;y` (command `:hint links yank`) — labels only the links and copies the URL of the chosen link to the clipboard (useful to share a link without visiting it).
  - `;t` (command `:hint inputs`) — labels only input/textarea elements, which is handy for pages with many form fields.
- Custom bindings that complement the defaults:
  - `,f` (command `:hint links tab`) — shows hints only for the links on the page and opens the chosen link in a new background tab.
  - `,F` (command `:hint links tab-fg`) — shows hints only for the links on the page and opens the chosen link in a new foreground tab.

### Jumping to input fields
- `gi` (command `:edit-text` / insert-mode on the first input) focuses the first input field on the page and enters insert mode automatically. If you have previously focused another input on the same page, `gi` returns to that one instead. This is often faster than using `;t` when the page has a single, obvious input (search boxes, login forms, etc.).

## Accessing urls quickly

- There are basically 2 ways to access urls quickly: bookmarks and quickmarks.
- The shortcut `Sq` (command `:bookmark-list`) lists all saved bookmarks and quickmarks. This is one of the ways to access urls quickly. You can run the command `:bookmark-list -t` if you want to open the listing in a new tab.
- In the bookmarks and quickmarks sections below, there are specific ways to access each of them. However, a very practical way to access both is through the command `:open` (shortcut `o`) or `:open -t` (shortcut `O`). Just start typing something and qutebrowser will search the bookmarks and quickmarks automatically in the URL bar suggestions.

### Bookmarks

- Bookmarks are favorite urls that you save to access later because you use them frequently.
- All your bookmarks are stored in the file `~/.config/qutebrowser/bookmarks/urls`.
- To save a bookmark of the current page, use the shortcut `M`. If you want to save a bookmark of a specific url, use the command `:bookmark-add [url] [title]`.
- To open a bookmark, you can use the shortcut `gb` (command `:bookmark-load`) or the shortcut `gB` (command `:bookmark-load -t` - new tab).

### Quickmarks

- Quickmarks associate a short name with a URL. They are named shortcuts. A bit different from bookmarks.
- All quickmarks are stored in the file `~/.config/qutebrowser/quickmarks`.
- To save a quickmark of the current page, use the shortcut `m` (command `:quickmark-save`). If you want to save a quickmark of a specific url, use the command `:quickmark-add [url] [name]`.
- To open a quickmark, you can use the shortcut `b` (command `:quickmark-load`) or the shortcut `B` (command `:quickmark-load -t` - new tab).

## Open URL from clipboard

- `pp` (command `:open -- {clipboard}`) opens the URL that is in the clipboard in the current tab.
- `pt` (command `:open -t -- {clipboard}`) opens the URL that is in the clipboard in a new tab.
