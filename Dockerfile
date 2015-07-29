FROM ubuntu
MAINTAINER Daniele Fornaciari, d.fornaciari@gmail.com

ENV DEBIAN_FRONTEND noninteractive
#ENV http_proxy http://172.17.0.1:8080
#ENV https_proxy http://172.17.0.1:8080
ENV ENV_GO_SERVER 127.0.0.1 
RUN apt-get install -y wget
#RUN apt-get update && apt-get -y upgrade
RUN echo "deb http://dl.bintray.com/gocd/gocd-deb/ /" > /etc/apt/sources.list.d/gocd.list
RUN wget --quiet -O - "https://bintray.com/user/downloadSubjectPublicKey?username=gocd" | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y go-agent git subversion
RUN apt-get clean
RUN sed -i 's/GO_SERVER=127.0.0.1/GO_SERVER=${ENV_GO_SERVER}/g' /etc/default/go-agent
RUN sed -i 's/DAEMON=Y/DAEMON=N/g' /etc/default/go-agent
RUN sed -i 's/su\ -\ go\ -c/su\ go\ -c/g' /etc/init.d/go-agent

CMD /bin/su - go -c /usr/share/go-agent/agent.sh go-agent


#ENV LDAP_BASEDN dc=piratenpartei,dc=ch
#COPY otrscron.sh /otrscron.sh

#EXPOSE 8153
