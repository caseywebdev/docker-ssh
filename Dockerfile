FROM debian:8.5

ENV CONTAINERPILOT file:///etc/containerpilot.json
ENV CONTAINERPILOT_VERSION 2.3.0
RUN apt-get update && \
    apt-get install -y openssh-server wget && \
    mkdir /var/run/sshd && \
    rm /etc/motd && \
    echo PasswordAuthentication no >> /etc/ssh/sshd_config && \
    wget -O - \
      https://github.com/joyent/containerpilot/releases/download/$CONTAINERPILOT_VERSION/containerpilot-$CONTAINERPILOT_VERSION.tar.gz | \
      tar xz -C /bin/

COPY etc/authorized_keys /root/.ssh/
COPY etc/containerpilot.json /etc/

EXPOSE 22

ARG VERSION
ENV VERSION $VERSION

CMD ["containerpilot", "/usr/sbin/sshd", "-D"]
