include:
  - httpd
  - certbot

{%- for site in ['aet.li'] %}
/etc/httpd/conf.d/sites/{{ site }}-http.conf:
  file.managed:
    - source: salt://httpd/template-http.conf.j2
    - template: jinja
    - replace: false
    - context:
        hostname: {{ site }}
        config: {{ slspath }}/{{ site }}-http.conf
    - watch_in:
      - service: httpd
    - require:
      - pkg: httpd
/etc/httpd/conf.d/sites/{{ site }}-https.conf:
  file.managed:
    - source: salt://httpd/template-https.conf.j2
    - template: jinja
    - replace: false
    - context:
        hostname: {{ site }}
        config: {{ slspath }}/{{ site }}-https.conf
    - watch_in:
      - service: httpd
    - require:
      - pkg: httpd
  cmd.run:
    - name: certbot --apache --non-interactive --agree-tos --domains {{ site }} --email aeternity@apeunit.com 
    - onchanges:
      - file: /etc/httpd/conf.d/sites/{{ site }}-https.conf
{%- endfor %}

httpd_can_network_connect:
    selinux.boolean:
      - value: true
      - persist: true
