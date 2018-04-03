include:
  - httpd
  - certbot

/etc/httpd/conf.d/sites/aet.li.conf:
  file.managed:
    - source: salt://httpd/template.conf.j2
    - template: jinja
    - replace: false
    - context:
        hostname: aet.li
        config: {{ slspath }}/aet.li.conf
    - watch_in:
      - service: httpd
    - require:
      - pkg: httpd
  cmd.run:
    - name: certbot --apache --non-interactive --agree-tos --domains aet.li --email aeternity@apeunit.com 
    - onchanges:
      - file: /etc/httpd/conf.d/sites/aet.li.conf

httpd_can_network_connect:
    selinux.boolean:
      - value: true
      - persist: true
