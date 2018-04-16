# Run Epoch

include:
  - docker

aeternity/epoch:
  docker_image.present:
    - name: aeternity/epoch:v0.10.1
  docker_container.running:
    - name: epoch
    - image: aeternity/epoch:v0.10.1
    - port_bindings:
      - 3013:3013
      - 3113:3113
    - binds:
      - /etc/epoch/config.yaml:/home/epoch/config.yaml:Z
      - epoch-db:/home/epoch/node/data/mnesia:rw
      - epoch-keys:/home/epoch/node/keys:rw
    - environment:
      - EPOCH_CONFIG: /home/epoch/config.yaml
    - require:
      - docker_image: aeternity/epoch
      - file: /etc/epoch/config.yaml
      - docker_volume: epoch-db
      - docker_volume: epoch-keys

epoch-db:
  docker_volume.present:
    - driver: local

epoch-keys:
  docker_volume.present:
    - driver: local

/etc/epoch/config.yaml:
  file.managed:
    - source: salt://epoch/config.yaml
    - makedirs: true
