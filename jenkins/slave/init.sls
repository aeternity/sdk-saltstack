# Install and run Jenkins slave

/usr/share/java/jenkins-slave.jar:
  file.managed:
    - source: https://{{salt['pillar.get']('ci:host')}}/jnlpJars/agent.jar
    - skip_verify: true

java:
  pkg.installed:
    - name: java-1.8.0-openjdk-headless
  
jenkins-slave:
  file.managed:
    - source: salt://jenkins/slave/jenkins-slave.service
    - name: /usr/lib/systemd/system/jenkins-slave.service
    - template: jinja
    - context:
        server: {{salt['pillar.get']('ci:host')}}
        secret: {{salt['pillar.get']('ci:secret')}}
        name: {{salt['grains.get']('host')}}
  service.running:
    - enable: true
    - watch:
      - file: jenkins-slave
    - require:
      - user: jenkins-slave
      - pkg: java
  user.present:
    - name: jenkins
    - fullname: Jenkins
    - home: /var/lib/jenkins
    - system: true
