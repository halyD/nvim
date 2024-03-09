# NeoVim Configs
### stay healthy
`:checkhealth`
### prerequisites
- **ripgrep** / fd, 
- clipboard : **xclip**, tmux native
- LSP : **pyright**, **clangd**, **bashls**, **zls** 
- luarocks

### changes
##### browse.nvim
- open_cmd = { "cmd.exe", "/c", "start" } to trigger browser app in WSL (under is_wsl())
- ~/.local/share/nvim/lazy/browse.nvim/lua/browse

##### lsp.nvim / cmp.nvim 
- remove old lsp & cmp configs

##### ShaDa error
- rm ~/.local/state/nvim/shada/*
