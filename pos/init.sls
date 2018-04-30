# Run POS middleware through Docker

{%- set image = '166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/pos' %}

include:
  - docker

republica/pos:
  docker_image.present:
    - name: {{ image }}
    - require:
      - cmd: ecr-login
    - force: true
  docker_container.running:
    - name: pos
    - image: {{ image }}
    - port_bindings: 5000:5000
    - binds:
      - /etc/pos/settings.json:/data/conf/settings.json:ro
    - links:
      - pos-postgres: db
    - ulimits: nofile=10000:10000
    - require:
      - docker_image: republica/pos
      - docker_container: postgres
    - watch:
      - file: republica/pos
  file.managed:
    - name: /etc/pos/settings.json
    - source: salt://pos/settings.json
    - makedirs: true
    - template: jinja

{%- for i in range(1,5) %}
republica/pos-{{ i }}:
  docker_container.running:
    - name: pos-{{ i }}
    - image: {{ image }}
    - command: start -c /data/conf/settings.json --no-poll
    - port_bindings: {{ 5000 + i }}:5000
    - binds:
      - /etc/pos/settings.json:/data/conf/settings.json:ro
    - links:
      - pos-postgres: db
    - ulimits: nofile=10000:10000
    - require:
      - docker_image: republica/pos
      - docker_container: postgres
    - watch:
      - file: republica/pos
{%- endfor %}

postgres:
  docker_image.present:
    - name: postgres:10.3
  docker_container.running:
    - name: pos-postgres
    - image: postgres:10.3
    - environment:
      - POSTGRES_USER: postgres
      - POSTGRES_PASSWORD: postgres
      - POSTGRES_DB: posapp
    - binds:
      - pos-db:/var/lib/postgresql/data:rw
      - /etc/pos/initdb.d:/docker-entrypoint-initdb.d:ro
    - require:
      - docker_image: postgres
      - docker_volume: pos-db
      - file: /etc/pos/initdb.d

/etc/pos/initdb.d:
  file.recurse:
    - source: salt://pos/initdb.d
    - clean: true

/etc/sudoers.d/salt-pos:
  file.managed:
    - source: salt://pos/sudo.conf

pos-db:
  docker_volume.present:
    - driver: local
