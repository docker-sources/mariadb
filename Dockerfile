FROM alpine:3.7

MAINTAINER Fabio J L Ferreira <fabiojaniolima@gmail.com>

# Caso queira, pode ser interessante incluir o cliente: mysql-client
RUN apk add --no-cache "mariadb<10.2" \
	&& rm -f /var/cache/apk/*

COPY mysql_start.sh /mysql_start.sh
RUN chmod +x /mysql_start.sh

COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306

CMD ["/mysql_start.sh"]