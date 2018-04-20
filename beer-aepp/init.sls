# Run Beer Aepp through Docker

include:
  - docker

republica/beer-aepp:
  docker_image.present:
    - name: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/beer-aepp
    - require:
      - cmd: ecr-login
    - force: true
  docker_container.running:
    - name: beer-aepp
    - image: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/beer-aepp
    - port_bindings: 3001:3000
    - require:
      - docker_image: republica/beer-aepp

/etc/sudoers.d/salt-beer-aepp:
  file.managed:
    - source: salt://beer-aepp/sudo.conf
