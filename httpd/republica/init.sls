include:
  - httpd
  - certbot

{%- for site in ['aet.li', 'republica.aepps.com'] %}
/etc/httpd/conf.d/sites/{{ site }}.conf:
  file.managed:
    - source: salt://httpd/template.conf.j2
    - template: jinja
    - replace: false
    - context:
        hostname: {{ site }}
        config: {{ slspath }}/{{ site }}.conf
    - watch_in:
      - service: httpd
    - require:
      - pkg: httpd
  cmd.run:
    - name: certbot --apache --non-interactive --agree-tos --domains {{ site }} --email aeternity@apeunit.com 
    - onchanges:
      - file: /etc/httpd/conf.d/sites/{{ site }}.conf
{%- endfor %}

httpd_can_network_connect:
    selinux.boolean:
      - value: true
      - persist: true
