# Run POS middleware through Docker

include:
  - docker

republica/pos:
  docker_image.present:
    - name: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/pos
    - require:
      - cmd: ecr-login
    - force: true
  docker_container.running:
    - name: pos
    - image: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/pos
    - port_bindings: 5001:5000
    - require:
      - docker_image: republica/pos

/etc/sudoers.d/salt-pos:
  file.managed:
    - source: salt://pos/sudo.conf
