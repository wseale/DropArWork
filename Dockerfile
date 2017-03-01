# Security Cam v2
#  - Finds ip address webcam - used for detecting motion
# Version 1.10.00
#FROM paradrop/workshop
#FROM ddvtech/mistserver
#FROM r0gger/mistserver
FROM ubuntu:16.04
#FROM bogem/ftp

#EXPOSE 21
#VOLUME /home/ftpuser /etc/pure-ftpd

# Apache site configuration
#ADD chute/000-default.conf /etc/apache2/sites-available/

#  Get the web frontend
#ADD chute/web /var/www/html

# Install files required by the chute.
#
# ADD <path_inside_repository> <path_inside_container>
#
# ADD chute/seccam.py /usr/local/bin/seccam.py
ADD chute/run.sh /usr/local/bin/run.sh

# Set the work dir for nodejs photo server
#WORKDIR "/var/www/html"

#EXPOSE 8080 1935 554 4242

#CMD ["/bin/bash", "/usr/local/bin/run.sh"]

##FROM bogem/ftp's github

FROM ubuntu:latest

RUN apt-get update && \
		apt-get install -y --no-install-recommends vsftpd db-util && \
		apt-get clean

ENV FTP_USER testa
ENV FTP_PASS testa
ENV PASV_ADDRESS 192.168.0.100

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh && \
		mkdir -p /var/run/vsftpd/empty

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 20 21

CMD ["/usr/sbin/run-vsftpd.sh"]

#now to loop and keep chute open
CMD ["/bin/bash", "/usr/local/bin/run.sh"]
