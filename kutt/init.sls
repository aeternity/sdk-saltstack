# Run kutt.it URL shortener using custom build

include:
  - docker

republica/kutt:
  docker_image.present:
    - name: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/kutt
    - require:
      - cmd: ecr-login
  docker_container.running:
    - name: kutt
    - image: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/kutt
    - links: neo4j:neo4j
    - port_bindings: 3000:3000
    - binds:
      - /etc/kutt/client.js:/code/client/config.js:Z
      - /etc/kutt/server.js:/code/server/config.js:Z
    - require:
      - docker_image: republica/kutt
      - docker_container: neo4j
      - file: /etc/kutt/client.js
      - file: /etc/kutt/server.js

/etc/kutt/client.js:
  file.managed:
    - source: salt://kutt/client.js
    - template: jinja
    - makedirs: true

/etc/kutt/server.js:
  file.managed:
    - source: salt://kutt/server.js
    - template: jinja
    - makedirs: true

neo4j:
  docker_image.present: []
  docker_container.running:
    - image: neo4j
    - environment:
      - NEO4J_AUTH: none
    - require:
      - docker_image: neo4j
    - binds:
      - neo4j-db:/data:rw
    - require:
      - docker_volume: neo4j-db

neo4j-db:
  docker_volume.present:
    - driver: local
