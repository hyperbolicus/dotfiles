---
misc_pkg:
  pkg.installed:
      - pkgs:
        {% if grains['os'] == 'MacOS' %}
        - caskroom/cask/firefox
        - caskroom/cask/thunderbird
        - caskroom/cask/keepassxc
        - caskroom/cask/vagrant
        - timewarrior
        - the_silver_searcher 
        - task
        {% endif %}
        {% if grains['os'] == 'Arch' %}
        - timew
        {% endif %}
        - tmux
        - neovim
        - ctags
        - htop
        - packer

