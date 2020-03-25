

acquire-letsencrypt:
	# Start-up nginx container with certbot installed and get a certificate if does not exist
	# Remove the container after it is done.
	docker-compose -f letsencrypt.docker-compose.yml up -d
	docker exec le_nginx bash /home/letsencrypt.sh $(domain)
	docker-compose -f letsencrypt.docker-compose.yml down --rmi all