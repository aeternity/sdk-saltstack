httpd:
  pkg.installed:
    - pkgs: [httpd, mod_ssl]
  service.running:
    - enable: true
    - require:
      - pkg: httpd
      - file: /etc/httpd/conf/httpd.conf

/etc/httpd/conf/httpd.conf:
  file.append:
    - text: 'IncludeOptional conf.d/sites/*.conf'
    - require:
      - pkg: httpd

/etc/httpd/conf.d/ssl.conf:
  file.managed:
    - source: salt://httpd/ssl.conf
    - require:
      - pkg: httpd

/etc/httpd/conf.d/sites:
  file.directory
