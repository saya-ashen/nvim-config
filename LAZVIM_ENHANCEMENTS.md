# Enhanced nvim-config - LazyVim-style improvements

This document summarizes the improvements made to make your nvim-config more like LazyVim while fixing the folding issues.

## 🔧 Fixed Issues

### Folding Bug
- **Problem**: Folds were auto-collapsing after being expanded
- **Solution**: 
  - Enhanced UFO configuration with LSP provider support
  - Added proper fold settings (`foldmethod = "manual"`, excluded folds from session)
  - Added UFO preview window with `zp` for peek functionality
  - Better fold keymaps: `zr`/`zm` for incremental folding

## 🚀 New LazyVim-style Features

### File Management
- **Neo-tree** (`<leader>e`): Full-featured file explorer with git status
- **Oil.nvim** (`<leader>o`): Buffer-based file editing
- **Mini.files** (`<leader>fm`): Minimal file browser

### Git Integration
- **Diffview** (`<leader>gd`): Advanced git diff viewer
- **Lazygit** (`<leader>gg`): Full git UI in floating terminal

### Enhanced Search & Replace
- **Spectre** (`<leader>sr`): Project-wide search and replace
- **Todo-comments**: Highlight TODO/FIXME with `]t`/`[t` navigation
- **Project.nvim** (`<leader>fp`): Project management

### Terminal Integration
- **Toggleterm**: Multiple terminal modes
  - `<leader>tt`: Toggle terminal
  - `<leader>tf`: Floating terminal
  - `<leader>th`: Horizontal split
  - `<leader>tv`: Vertical split
  - `<leader>tn`: Node REPL
  - `<leader>tp`: Python REPL

### Better Navigation
- **Vim-illuminate**: Highlight word under cursor with `]]`/`[[` navigation
- **Spider**: Smarter word motions (enhanced `w`/`e`/`b`)
- **Buffer management**: Smart buffer deletion (`<leader>bd`) with save prompts

### UI Improvements
- **Statuscol**: Better status column with fold indicators
- **Enhanced keymaps**: LazyVim-style shortcuts
- **Better which-key groups**: Organized leader key menus

## ⌨️ Key Bindings (LazyVim-style)

### File & Project
- `<leader>e`: Neo-tree explorer
- `<leader>o`: Oil file editor  
- `<leader>fm`: Mini.files
- `<leader>fp`: Project picker
- `<leader>fn`: New file

### Git
- `<leader>gg`: Lazygit
- `<leader>gd`: Diffview open
- `<leader>gc`: Diffview close
- `<leader>gh`: File history

### Search
- `<leader>sr`: Spectre search/replace
- `<leader>st`: Todo telescope
- `<leader>sw`: Search word under cursor

### Buffers & Windows
- `<S-h>`/`<S-l>`: Previous/Next buffer
- `<leader>bd`: Delete buffer (smart)
- `<leader>bb`: Switch to other buffer
- `<C-h/j/k/l>`: Window navigation
- `<C-arrows>`: Resize windows

### Lines & Movement  
- `<A-j>`/`<A-k>`: Move lines up/down
- `]]`/`[[`: Next/Previous reference (illuminate)
- `]t`/`[t>`: Next/Previous todo comment

### Terminal
- `<leader>tt`: Toggle terminal
- `<leader>tf`: Float terminal
- `<C-\>`: Quick terminal toggle

### Folding (Fixed!)
- `zp`: Peek fold
- `zr`/`zm`: Incremental fold less/more
- `zR`/`zM`: Open/Close all folds

## 🛠️ Technical Details

### Plugins Added
- neo-tree.nvim, oil.nvim: File management
- toggleterm.nvim: Terminal integration  
- diffview.nvim: Git diff/merge
- nvim-spectre: Search/replace
- todo-comments.nvim: Comment highlighting
- project.nvim: Project management
- vim-illuminate: Reference highlighting
- nvim-spider: Better word motion
- statuscol.nvim: Status column
- mini.bufremove: Buffer management

### Fold Fix Details
The folding issue was caused by:
1. Missing LSP provider in UFO configuration
2. Inadequate fold settings
3. Session management interfering with fold state

Fixed by:
1. Adding LSP to UFO provider list
2. Setting `foldmethod = "manual"`
3. Excluding folds from session options
4. Adding preview window configuration

Your nvim-config now provides a comprehensive LazyVim-like experience while maintaining the nixCats architecture!