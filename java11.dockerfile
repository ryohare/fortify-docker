FROM amazoncorretto:11

RUN yum update -y && yum install -y git wget vim tar

WORKDIR /tmp

COPY . /tmp

# install fortify
RUN ./Fortify_SCA_and_Apps_19.2.2_linux_x64.run --mode unattended --installdir /opt/fortify --InstallSamples 0 --fortify_license_path ./fortify.license --UpdateServer https://fortify.synchronoss.com/ssc

# install maven
RUN wget http://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar -xf apache-maven-3.6.3-bin.tar.gz
RUN mv apache-maven-3.6.3/ /opt/apache-maven/

# TODO install other java build systems (gradle, ant, etc)

# clean up tmp
RUN rm -rf /tmp/*

#update path vars
ENV PATH="/opt/fortify/bin:${PATH}"
ENV PATH="/opt/apache-maven/bin:${PATH}"

# set new work dir
WORKDIR /fortify
