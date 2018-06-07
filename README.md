# crear una imagen con el Dockerfile
docker build . -t nombre_imagen_a_crear

# con la imagen creada levantar los 6 dockers siguientes

docker run -d -p 2020:8080 -e PBA=calculadora1 nombre_imagen_creada

docker run -d -p 3030:8080 -e PBA=calculadora2 nombre_imagen_creada

docker run -d -p 4040:8080 -e PBA=calculadora3 nombre_imagen_creada

docker run -d -p 5050:8080 -e PBA=calculadora4 nombre_imagen_creada

docker run -d -p 6060:8080 -e PBA=calculadora5 nombre_imagen_creada

docker run -d -p 7070:8080 -e PBA=calculadora6 nombre_imagen_creada

# Balanceador con haProxy
# -----------------------------------

# actualizamos las dependencias del Sistema Operativo Ubuntu
sudo apt-get update

# instalamos haproxy
sudo apt-get install haproxy

# configuramos haproxy
# -------------------------------------------

# modificar el archivo siguiente 
sudo nano /etc/default/haproxy

# descomentar la linea siguiente
CONFIG="/etc/haproxy/haproxy.cfg"

# agregar al final del archivo la linea siguiente
ENABLED=1

# editamos el archivo de configuracion
sudo nano /etc/haproxy/haproxy.cfg

# al final del archivo agregamos las siguientes lineas
frontend www

        bind 0.0.0.0:9090

        default_backend site_backend

backend site_backend

        mode http

        stats enable

        stats uri /haproxy?stats

        balance roundrobin

        server lamp1 localhost:2020 check

        server lamp2 localhost:3030 check

	server lamp3 localhost:4040 check

	server lamp3 localhost:5050 check

	server lamp3 localhost:6060 check

	server lamp3 localhost:7070 check
	
# detener e iniciar el serivcio haproxy
sudo service haproxy stop
sudo service haproxy start

# ejecutar en un navegador la siguiente url para probar que el balanceador este funcionando
http://localhost:9090/api/calculadora?operacion=divide&valor1=15&valor2=5

# ejecutar el script bombardeo.sh para meter carga al balanceador
sh bombardeo.sh

# verificamos las estadisticas del balanceador ingresando a 
http://localhost:9090/haproxy?stats
