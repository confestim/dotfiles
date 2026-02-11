{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Theme
      dracula-nvim

      # UI
      nerdtree
      vim-devicons
      nvim-web-devicons
      vim-airline
      barbar-nvim
      tagbar
      vim-startify
      vim-wakatime
      # Navigation & Search
      telescope-nvim
      plenary-nvim

      # Git
      vim-fugitive

      # Utilities
      vim-surround
      vim-commentary
      vim-multiple-cursors
      neoformat
      nvim-jqx

      # Copilot
      copilot-vim

      # CoC (Completion)
      coc-nvim
      coc-pyright
      coc-clangd
      coc-rust-analyzer

      # Language Support
      vim-nix
      haskell-vim
      rust-vim
      vim-css-color
      pgsql-vim
      vimtex

      # Focus mode
      limelight-vim

      # Misc
      vim-emoji
      awesome-vim-colorschemes
    ];

    extraConfig = ''
      " Basic settings
      set number
      set relativenumber
      set autoindent
      set expandtab
      set tabstop=2
      set shiftwidth=2
      set smarttab
      set softtabstop=2
      set mouse=a
      set encoding=UTF-8
      set completeopt-=preview

      " Colorscheme
      colorscheme dracula

      " Emoji autocomplete
      set completefunc=emoji#complete

      " NERDTree
      let g:NERDTreeDirArrowExpandable="+"
      let g:NERDTreeDirArrowCollapsible="~"
      nnoremap <C-n> :NERDTree<CR>
      nnoremap <C-t> :NERDTreeToggle<CR>

      " CoC
      nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
      inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

      " Tagbar
      nmap <F8> :TagbarToggle<CR>

      " Auto pairs
      inoremap { {}<left>
      inoremap {{ {
      inoremap {} {}
      inoremap [ []<left>
      inoremap [[ [
      inoremap [] []
      inoremap ( ()<left>
      inoremap (( (
      inoremap () ()
      inoremap " ""<left>
      inoremap "" ""
      inoremap ' <Char-39><Char-39><left>
      inoremap <Char-39><Char-39> <Char-39><Char-39>
      " ========== CLIPBOARD FIX ==========
      " Use system clipboard for all operations
      set clipboard=unnamedplus
      
      " Make sure we can use system clipboard
      if has('unnamedplus')
        set clipboard=unnamedplus
      else
        set clipboard=unnamed
      endif

      " Tab navigation
      nnoremap <Tab> >>
      nnoremap <S-Tab> 

      " Airline
      let g:airline_powerline_fonts = 1
      if !exists('g:airline_symbols')
          let g:airline_symbols = {}
      endif
      let g:airline_left_sep = '>'
      let g:airline_left_alt_sep = '|'
      let g:airline_right_sep = '<'
      let g:airline_right_alt_sep = '|'
      let g:airline_symbols.branch = 'b'
      let g:airline_symbols.readonly = 'x'
      let g:airline_symbols.linenr = '#'

      " Limelight
      let g:limelight_conceal_ctermfg = 'gray'
      let g:limelight_conceal_ctermfg = 240

      " LaTeX
      filetype plugin indent on
      set grepprg=grep\ -nH\ $*
      let g:tex_flavor = "latex"

      " Neoformat
      let g:neoformat_basic_format_retab = 1

      " Markdown Preview
      let g:nvim_markdown_preview_theme = 'solarized-dark'
      let g:mkdp_auto_start = 0
      let g:mkdp_auto_close = 1
      let g:mkdp_refresh_slow = 0
      let g:mkdp_command_for_global = 0
      let g:mkdp_open_to_the_world = 0
      let g:mkdp_open_ip = ""
      let g:mkdp_browser = ""
      let g:mkdp_echo_preview_url = 0
      let g:mkdp_browserfunc = ""
      let g:mkdp_preview_options = {
          \ 'mkit': {},
          \ 'katex': {},
          \ 'uml': {},
          \ 'maid': {},
          \ 'disable_sync_scroll': 0,
          \ 'sync_scroll_type': 'middle',
          \ 'hide_yaml_meta': 1,
          \ 'sequence_diagrams': {},
          \ 'flowchart_diagrams': {},
          \ 'content_editable': v:false,
          \ 'disable_filename': 0,
          \ 'toc': {}
          \ }
      let g:mkdp_markdown_css = ""
      let g:mkdp_highlight_css = ""
      let g:mkdp_port = ""
      let g:mkdp_filetypes = ['markdown']
      let g:mkdp_theme = 'dark'

      " Barbar (tab bar)
      nnoremap <silent>    <A-Left> <Cmd>BufferPrevious<CR>
      nnoremap <silent>    <A-Right> <Cmd>BufferNext<CR>
      nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
      nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>
      nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
      nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
      nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
      nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
      nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
      nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
      nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
      nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
      nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
      nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
      nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
      nnoremap <silent>    <A-q> <Cmd>BufferClose<CR>
      nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
      nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
      nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
      nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
      nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

      " Startify
      let g:webdevicons_enable_startify = 1
      let s:startify_ascii_header = [
       \ '                                        ▟▙            ',
       \ '                                        ▝▘            ',
       \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
       \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
       \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
       \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
       \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
       \ ' ',
       \]
      let g:startify_custom_header = map(s:startify_ascii_header +
              \ startify#fortune#quote(), '"   ".v:val')
    '';
  };
  # CoC extensions
  home.file.".config/nvim/coc-settings.json".text = ''
    {
      "suggest.noselect": false,
      "suggest.enablePreselect": true,
      "diagnostic.checkCurrentLine": true,
      "diagnostic.errorSign": "✘",
      "diagnostic.warningSign": "⚠",
      "diagnostic.infoSign": "ℹ",
      "diagnostic.hintSign": "➤",
      "languageserver": {
        "haskell": {
          "command": "haskell-language-server-wrapper",
          "args": ["--lsp"],
          "filetypes": ["haskell", "lhaskell"],
          "rootPatterns": ["*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"],
          "settings": {
            "haskell": {
              "formattingProvider": "ormolu",
              "checkProject": true
            }
          }
        }
      },
      "python.linting.enabled": true,
      "python.linting.pylintEnabled": true,
      "inlayHint.enable": true,
      "pyright.inlayHints.variableTypes": true,
      "pyright.inlayHints.functionReturnTypes": true,
      "clangd.path": "clangd",
      "clangd.arguments": [
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed"
      ],
      "rust-analyzer.server.path": "rust-analyzer",
      "rust-analyzer.check.command": "clippy",
      "rust-analyzer.inlayHints.typeHints.enable": true,
      "rust-analyzer.inlayHints.parameterHints.enable": true
    }
  '';

  # LSP binaries
  home.packages = with pkgs; [
    # Haskell
    haskell-language-server
    ghc
    cabal-install
    ormolu

    # Python
    pyright
    python3Packages.pylint

    # C/C++
    clang-tools
    clang

    # Rust
    rust-analyzer
    rustc
    cargo
    clippy
  ];
}
