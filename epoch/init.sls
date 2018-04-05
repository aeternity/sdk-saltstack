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
    - environment:
      - EPOCH_CONFIG: /home/epoch/config.yaml
    - require:
      - docker_image: aeternity/epoch
      - file: /etc/epoch/config.yaml

/etc/epoch/config.yaml:
  file.managed:
    - source: salt://epoch/config.yaml
    - makedirs: true
