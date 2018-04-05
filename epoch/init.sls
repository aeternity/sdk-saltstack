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
      - 3014:3014
    - volumes:
      - {{ slspath }}/epoch.yaml:/home/epoch/epoch.yaml:Z
    - environment:
      - EPOCH_CONFIG: /home/epoch/epoch.yaml
    - require:
      - docker_image: aeternity/epoch
