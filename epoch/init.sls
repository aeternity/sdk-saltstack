# Run Epoch

include:
  - docker

aetrnty/epoch:
  docker_image.present:
    - name: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/aetrnty/epoch:v0.10.0
    - require:
      - cmd: ecr-login
  docker_container.running:
    - name: epoch
    - image: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/aetrnty/epoch
    - port_bindings: 3013:3013
    - require:
      - docker_image: aetrnty/epoch
