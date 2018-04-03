# Make sure docker-ce is installed but supply its dedicated partition, first.

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
  pip.installed: []
