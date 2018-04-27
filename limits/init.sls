# Increase system limits

/etc/security/limits.d/10-nofile.conf:
  file.managed:
    - source: salt://limits/nofile.conf
