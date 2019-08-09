---
{% set user = salt['cmd.shell']("id -un") %}
{% set group = salt['cmd.shell']("id -gn") %}
install_neomutt:
  pkg.installed:
    - pkgs:
      - neomutt
      - isync
      - gpg
      - pass

ensure_conf_dir:
  file.directory:
    - name: ~/.config/neomutt
    - makedirs: true
    - user: {{ user }}
    - group: {{ group }}



