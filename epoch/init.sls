# Run Epoch

include:
  - docker

aeternity/epoch:
  docker_image.present:
    - name: aeternity/epoch:v0.10.0
  docker_container.running:
    - name: epoch
    - image: aeternity/epoch
    - port_bindings:
      - 3013:3013
      - 3014:3014
    - require:
      - docker_image: aeternity/epoch
