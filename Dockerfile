#Sélection de l'image de référence ici centos en version 7
FROM centos:7

#Installation de java SE 8
RUN curl -v -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.tar.gz | \
    tar -xzC /usr/local/ && \
    alternatives --install /usr/bin/java java /usr/local/jdk1.8.0_73/bin/java 2
ENV JAVA_HOME /opt/jdk1.8.0_72

#Installation de Scala en version 2.10.6
RUN curl -SL http://downloads.lightbend.com/scala/2.10.6/scala-2.10.6.rpm > scala-2.10.6.rpm && \
    yum install -y scala-2.10.6.rpm && \
    rm -f scala-2.10.6.rpm

#Installation de spark 1.6.1 avec les complément hadoop 2.6
RUN curl -SL http://apache.crihan.fr/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz | \
    tar -xzC /usr/local/ && \
    ln -s /usr/local/spark-1.6.1-bin-hadoop2.6 /usr/local/spark

#Ajout des binaires Spark au PATH
ENV PATH $PATH:/usr/local/spark/bin

#Configuration de Spark depuis le dossier de configuration
ADD conf/log4j.properties /usr/local/spark/conf/log4j.properties

