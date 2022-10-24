FROM ubuntu:22.04
# Actualizamos el ubuntu
RUN apt-get update && apt-get -y upgrade
# Instalamos el ssh server, el apache, el mysql, el python  y el supervisor
RUN apt-get install -y openssh-server

RUN apt-get install -y supervisor

RUN apt-get install -y apache2

RUN apt-get install -y mysql-server

RUN apt-get install -y python3

# Creamos directorios que necesitan el supervisor, el apache y el ssh
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

# Copiamos el fichero supervisord.conf que hemos creado fuera del container
# y lo pegamos en /etc/supervisor/conf.d/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Declaramos los puertos que usan los servicios que queremos que inicie supervisor
EXPOSE 22 80 443 9001 3306

# Declaramos que por defecto se inicie el supervisor en vez del rooot
CMD ["/usr/bin/supervisord"]
