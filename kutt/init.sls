# Run kutt.it URL shortener using custom build

include:
  - docker
  - aws

republica/kutt:
  docker_image.present:
    - name: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/kutt
    - require:
      - cmd: republica/kutt
  docker_container.running:
    - name: kutt
    - image: 166568770115.dkr.ecr.eu-central-1.amazonaws.com/republica/kutt
    - links: neo4j:neo4j
    - port_bindings: 3000:3000
    - require:
      - docker_image: republica/kutt
      - docker_container: neo4j
  cmd.run:
    - name: $(aws ecr get-login --no-include-email --region eu-central-1)

neo4j:
  docker_image.present: []
  docker_container.running:
    - image: neo4j
    - environment:
      - NEO4J_AUTH: none
    - require:
      - docker_image: neo4j
