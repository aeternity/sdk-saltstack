# Make sure docker-ce is installed but supply its dedicated partition, first.

include:
  - aws

docker:
  mount.mounted:
    - name: /var/lib/docker
    - device: LABEL=data
    - fstype: btrfs
    - mkmnt: True
    - opts: subvol=/docker
  pkgrepo.managed:
    - name: docker-ce-stable
    - humanname: Docker CE Stable - $basearch
    - baseurl: https://download.docker.com/linux/centos/7/$basearch/stable
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://download.docker.com/linux/centos/gpg
  pkg.installed:
    - name: docker-ce
    - require:
      - pkgrepo: docker
      - mount: docker
  service.running:
    - enable: true
    - require:
      - pkg: docker
    - watch:
      - file: /etc/systemd/system/docker.service.d/override.conf
  pip.installed: []

ecr-login:
  cmd.run:
    - name: $(aws ecr get-login --no-include-email --region eu-central-1)
    - require:
      - file: /root/.aws/credentials

/etc/systemd/system/docker.service.d/override.conf:
  file.managed:
    - source: salt://docker/override.conf
    - makedirs: true
  cmd.run:
    - name: systemctl daemon-reload
    - watch:
      - file: /etc/systemd/system/docker.service.d/override.conf
