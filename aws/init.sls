# AWS CLI support

awscli:
  pkg.installed

/root/.aws/credentials:
  file.managed:
    - source: salt://aws/credentials.conf
    - template: jinja
    - makedirs: true
    - mode: '0600'
