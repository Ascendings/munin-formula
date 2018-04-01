{% from "munin/map.jinja" import munin_master with context %}

include:
  - munin.master

munin_master_config:
  file.managed:
    - name: {{ munin_master.config }}
    - source: {{ munin_master.config_src }}
    - template: jinja
    - user: {{ munin_master.file_user }}
    - group: {{ munin_master.file_group }}
    - mode: 644

