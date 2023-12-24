# NeoVim Configs

### prerequisites
- **ripgrep** / fd
- clipboard : **xclip**
- LSP : **pyright**, **clangd**, **bashls**, and such

### changes
##### browse.nvim
- open_cmd = { "cmd.exe", "/c", "start" } to trigger browser app in WSL (under is_wsl())
- ~\.local\share\nvim\lazy\browse.nvim\lua\browse (WSL -> \)
