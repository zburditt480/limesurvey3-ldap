# limesurvey3-ldap
Limesurvey 3 (LTS) container with ldaps pre-enabled

Limesurvey Version: 3.22.4+200212

To run the container immediately:

docker run -d --name <container name> zburditt480/limesurvey

If you want it to be accessible from outside of localhost you will need to open ports:

docker run -d --name limesurvey -p 80:80 -p 443:443 zburditt480/limesurvey

I recommend putting the container behind a proxy instead of exposing ports. Then configure your certificates for the proxy.

Docker Compose If you want to run the container as a docker-compose project you do something like this:

version: "2"
services:
  limesurvey:
    image: zburditt480/limesurvey
    container_name: "limesurvey-${DEPLOY}"
    volumes:
      - "/var/log/docker/limesurvey-${DEPLOY}:/var/log/apache2"
    environment:
      - "TZ=America/Chicago"
    networks:
      - webtools
  db:
    image: mariadb:latest
    container_name: "lime_db-${DEPLOY}"
    volumes:
    environment:
      - "MYSQL_ROOT_PASSWORD=${ROOT_PWD}"
      - "TZ=America/Chicago"
    networks:
      - limesurvey
    ports:
      - "3306:3306"
networks:
  limesurvey:
    external:
      name: "${NETWORK}-${DEPLOY}"
Note the environment variables used will need to be set in a .env file in the same directory as the docker-compose.yml file.

The network limesurvey will need to be created beforehand. This allows the database and limesurvey to communicate directly as if they are on the same LAN.
