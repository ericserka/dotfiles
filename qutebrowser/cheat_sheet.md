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

- Temos basicamente 2 formas de acessar urls rapidamente, bookmarks e quickmarks.
- O atalho `Sq` (comando `:bookmark-list`) lista todos os bookmarks e quickmarks salvos. Essa é uma das formas de acessar as urls rapidamente. Você pode executar o comando `:bookmark-list -t` se desejar abrir a listagem em uma nova aba.
- Nas seções de bookmarks e quickmarks abaixo, existem formas específicas de acessar cada um deles. Porém, uma forma bem prática de acessar ambos é a partir do comando `:open` (atalho `o`) ou `:open -t` (atalho `O`). Basta começar a digitar algo e o qutebrowser vai buscar nos bookmarks e quickmarks automaticamente nas sugestões da barra de URL. 

### Bookmarks

- Bookmarks são urls favoritas que você salva para acessar depois pois utiliza com frequência.
- Todos os seus bookmarks ficam armazenados no arquivo `~/.config/qutebrowser/bookmarks/urls`.
- Para salvar o bookmark da página atual, utilize o atalho `M`. Se desejar salvar o bookmark de uma url específica, utilize o comando `:bookmark-add [url] [title]`.
- Para abrir um bookmark, você pode utilizar o atalho `gb` (comando `:bookmark-load`) ou o atalho
`gB` (comando `:bookmark-load -t` - nova aba)

### Quickmarks

- Quickmarks associam um nome curto a uma URL. São atalhos nomeados. Um pouco diferente dos bookmarks.
- Todos quickmarks ficam armazenados no arquivo `~/.config/qutebrowser/quickmarks`.
- Para salvar o quickmark da página atual, utilize o atalho `m` (comando `:quickmark-save`). Se desejar salvar o quickmark de uma url específica, utilize o comando `:quickmark-add [url] [name]`.
- Para abrir um quickmark, você pode utilizar o atalho `b` (comando `:quickmark-load`) ou o atalho
`B` (comando `:quickmark-load -t` - nova aba)
