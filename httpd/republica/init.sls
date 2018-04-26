include:
  - httpd
  - certbot

{%- for site in ['aet.li', 'republica.aepps.com', 'republica-pos.aepps.com'] %}
/etc/httpd/conf.d/sites/{{ site }}.conf:
  file.managed:
    - source: salt://httpd/template.conf.j2
    - template: jinja
    - replace: false
    - context:
        hostname: {{ site }}
        https_config: {{ slspath }}/{{ site }}-https.conf
        http_config: {{ slspath }}/{{ site }}-http.conf
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
