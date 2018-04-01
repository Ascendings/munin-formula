{% from "munin/map.jinja" import munin_master with context %}

include:
  - munin.master

{% if salt['grains.get']('os_family') == 'Arch' %}
cron_service:
  file.managed:
    - name: {{ munin_master.cron_service }}
    - source: salt://munin/files/Arch/munin-cron.service
    - user: {{ munin_master.file_user }}
    - group: {{ munin_master.file_group }}
    - mode: 644

cron_timer:
  file.managed:
    - name: {{ munin_master.cron_timer }}
    - source: salt://munin/files/Arch/munin-cron.timer
    - user: {{ munin_master.file_user }}
    - group: {{ munin_master.file_group }}
    - mode: 644

munin-cron.timer:
  service.running:
    - enable: True
    - watch:
      - file: cron_service
      - file: cron_timer

{% endif %}
{% if salt['grains.get']('os_family') == 'Suse' %}
munin-cron:
  service.running:
    - name: cron
    - enable: True
{% endif %}
