#!/usr/bin/env bash

#Stop the script when exit code is not success with any of the lines.
set -e

# letsencrypt files reside in /etc/letsencrypt/ directory
LE_PATH="/etc/letsencrypt"

# get which domain name to be fetch certificate for.
DOMAIN_NAME=$1
if [ "$(ls -A $LE_PATH)" ]
then
    echo "Directory $LE_PATH is not empty."
    # We can renew the certificates here if they are close to expiration.

else
    # Get certbot letsencrypt ceftificate.
    # Ensure certbot is installed
    if ! [ -x "$(command -v certbot)" ]; then
      echo "Error: certbot is not installed." >&2
      echo "Install certbot and try again" >&2
      echo "RUN sudo apt-get install certbot python-certbot-nginx to install missing software to continue" >&2
      exit 1
    fi
    # Continue with certificate generation.
    # -n flag will be non-interactive
    # -d | --domains will specify which ones to get certificate for.
    echo "Obtaining Letsencrypt certificate."
    certbot certonly --nginx -n --domains ${DOMAIN_NAME} --agree-tos -m "example@mydomain.org"

fi
# This assumes you have a volume defined for nginx container  as `deploy/etc/letsencrypt:/etcletsencrypt`
echo "Acquiring/Renewing certificate is completed."
echo "You can remove this container and deploy your app now with SSL setup."