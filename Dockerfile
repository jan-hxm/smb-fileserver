FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    samba \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/samba
RUN mkdir -p /etc/samba

COPY smb.conf /etc/samba/smb.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Expose SMB ports
EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 139
EXPOSE 445

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/smbd", "-F", "--no-process-group"]
