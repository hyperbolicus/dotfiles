self: super: {
	neovim =  super.neovim.override {
          viAlias = true;
          vimAlias = true;
          configure = {
            customRC = ''
            set hidden
            set noswapfile
            set smartcase
            set smarttab
            set smartindent
            set autoindent
            set expandtab
            set shiftwidth=2
            set softtabstop=2
            set background=dark
            set laststatus=2
            set ignorecase
            set wildmode=longest,list,full
            set nu
            '';
        };
  };
  }
