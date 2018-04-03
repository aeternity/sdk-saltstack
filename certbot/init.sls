# Install certbot w/httpd plugin

certbot:
  pkg.installed:
    - pkgs: [certbot, python2-certbot-apache]

/etc/systemd/system/certbot.service:
  file.managed:
    - source: salt://certbot/certbot.service

/etc/systemd/system/certbot.timer:
  file.managed:
    - source: salt://certbot/certbot.timer
    - require:
      - file: /etc/systemd/system/certbot.service
    - watch_in:
      - service: certbot.timer

certbot.timer:
  service.running:
    - enable: true
    - require:
      - file: /etc/systemd/system/certbot.timer
      - pkg: certbot
