FROM debian:8.5

ENV CONTAINERPILOT_VERSION 2.3.0
RUN apt-get update && \
    apt-get install -y openssh-server && \
    echo PasswordAuthentication no >> /etc/ssh/sshd_config && \
    wget -O - \
      https://github.com/joyent/containerpilot/releases/download/$CONTAINERPILOT_VERSION/containerpilot-$CONTAINERPILOT_VERSION.tar.gz | \
      tar xz -C /usr/local/bin/

COPY trusted_keys /root/.ssh/authorized_keys
COPY containerpilot.json /usr/local/etc/containerpilot.json

EXPOSE 22

ARG VERSION
ENV VERSION $VERSION

CMD ["containerpilot", "-config", "file:///usr/local/etc/containerpilot.json",  "/usr/sbin/sshd", "-D"]
