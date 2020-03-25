# letsencrypt-docker

I've created this repo to help others to utilize creating a LetsEncrypt SSL certificate for your domains.

### letsencrypt.nginx.Dockerfile

This Dockerfile is to define the nginx image with `certbot and python-certbot-nginx` and also copy the `letsencrypt.sh`
 into it.
 
 The reason we execute that script inside the docker container, so we do not have to do any clean-up or modification to our existing server
 
It will simply create an Nginx image with certbot and certbot nginx dependencies installed defined in [Certbot Documentation](https://certbot.eff.org/lets-encrypt/debianbuster-nginx)

___it is important to note that at the time of writing this, Docker Nginx image is created using Debian(buster) not Ubuntu___

### letsencrypt.docker-compose.yml

We define the ports and entrypoint command for docker-compose to create the defined image and start it.  
It also exposes port 80 and it has to because certbot challange takes place only on port 80.

This is one of the reasons `letsencrypt.sh` runs inside the container so you can get rid of it after it is acquired.

### letsencrypt.sh

This is very simple script that checks is there is any existing certificate and exits if there is  
If not, it will try to acquire the certificate to given domain name using nginx as the server and provided domain name.
It will start the server itself and do the challenge.

### How to run the script?
the script takes one paramater but yu can edit it more to your liking if you wish

`bash letsencrypt.sh mydomain.com`

Make sure this is done inside the docker container which is running
To do that, simply run `docker exec le_nginx bash /home/letsencrypt.sh mydomain.com`

__Please remember to update your email address inside the script before doing any of this.__

You can also utilize the Makefile command created as `make acquire-letsencrypt domain=mydomain.com`