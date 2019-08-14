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
{% for i in pillar.get('mbsync') %}
~/.mail/{{ i['name'] }}:
  file.directory:
    - makedirs: true
    - user: {{ user }}
    - group: {{ group }}
    - dir_mode: 700
    - file_mode: 600
    - recurse: 
      - user
      - group
      - mode

{% endfor -%}
creating_mbsync:
  file.managed:
    - name: ~/.mbsyncrc
    - template: jinja
    - source: salt://neomutt/mbsyncrc
    - user: {{ user }}
    - group: {{ group }}
    - mode: 400


