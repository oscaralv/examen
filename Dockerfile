FROM gustavoarellano/jdk18
RUN apt-get update
RUN apt-get install -y nano
COPY sample-1.0-SNAPSHOT-fat.jar /home
COPY entry.sh /home/entry.sh
ENTRYPOINT ["/home/entry.sh"]  
