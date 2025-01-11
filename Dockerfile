# Use a minimal base image with bash
FROM ubuntu:20.04

# Install SSH and other required utilities
RUN apt-get update && \
    apt-get install -y openssh-server sudo curl && \
    mkdir /var/run/sshd

# Set the root password
RUN echo 'root:root' | chpasswd

# Set up a user named 'vagrant' with passwordless sudo
RUN useradd -ms /bin/bash vagrant && \
    echo 'vagrant:vagrant' | chpasswd && \
    adduser vagrant sudo

# Allow SSH access for the vagrant user
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Create vagrant user & install Ansible
RUN mkdir -p /home/vagrant/.ssh && \
    curl https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant:vagrant /home/vagrant/.ssh && \
    chmod 700 /home/vagrant/.ssh && \
    chmod 600 /home/vagrant/.ssh/authorized_keys && \
    apt update && apt install software-properties-common --yes && \
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt install ansible --yes && \
    apt install vim --yes

# Expose the SSH port
EXPOSE 22

# Start the SSH daemon and keep the container running
CMD ["/usr/sbin/sshd", "-D"]
