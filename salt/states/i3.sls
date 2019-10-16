# vi: set ft=yaml : 

i3:
  pkg.installed:
    - pkgs:
      - i3-gaps
      - i3blocks
      - i3lock
      - i3status
      - xterm
      
xorg:
  pkg.installed:
    - pkgs:
      - xorg
      - xorg-fonts-misc

{% if grains['os'] == 'Arch' %}
install_neo:
  file.managed:
    - source: http://neo-layout.org/xkb.tgz
    - source_hash: sha512=454daa00b28286acf291f441e39df030aef511ce9842bbafe0e25dcff43dd4d955bddfe193e63e7e6cabc31c5a02d596371c8095aa150cf2c25ffa6296da18e3
    - name: /tmp/xkb.tgz

'tar -C /usr/share/X11/ -xzf /tmp/xkb.tgz':
  cmd.run 

{% endif %}

