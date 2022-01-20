FROM ubuntu
RUN apt update \
    && apt install -y gqrx-sdr \
                      pulseaudio \
                      gr-osmosdr \
                      openssh-server \
                      x11-apps \
                      xauth \
                      vim \
    && mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh \
    && ssh-keygen -A \
    && sed -i "s/^.*PasswordAuthentication.*$/PasswordAuthentication no/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
    && mkdir -p /var/run/dbus
    && dbus-daemon --system

RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAopAZM6LCK82em0/ktsJoiXjqJxLBb8Ty3eVE219j5sRZUrQ9Z0a7oTJI/qahQbX8GnpPlgZz36XdQVlxc5gZVKi9tBuHQwovUlnOJm6FloCG9yA4NbuiMc3AKE6UbVXri1NJ8KXuOkQIC6I+oB2VQAJptmoL3+5wViw0mu/IjaVfrGuyOxuC64ci6bLjDZZZcqoXXzTpIfbj7imSt+sBH4cDKjGT1axuysPiPiT993ATbGVnOW1FIVy3s3DY5KyVB0xzX5Rbn+plwQsx7vaham+5wMgwMDLu/wRjLla4mPfxmD62aZqBNSOBFSILfwcLoqiwOq2CchP4h4romkmacQ== kris@theendless.org" >> /root/.ssh/authorized_keys

ENTRYPOINT ["sh", "-c", "/usr/sbin/sshd && tail -f /dev/null"]
