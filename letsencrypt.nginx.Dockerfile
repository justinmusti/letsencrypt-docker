FROM nginx:1.17.9

RUN apt update && apt upgrade

# certbot needs the following to perform certificate generation
RUN apt-get -y install certbot python-certbot-nginx

#Copy ovber the script to execuate certbot process.
COPY ./letsencrypt.sh /home/letsencrypt.sh

# Make it executable.
RUN chmod +x /home/letsencrypt.sh
