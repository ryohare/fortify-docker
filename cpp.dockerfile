FROM centos

RUN yum update -y && yum install -y git wget vim gcc gcc-c++ make cmake

WORKDIR /tmp

COPY . /tmp

# install fortify
RUN ./Fortify_SCA_and_Apps_19.2.2_linux_x64.run --mode unattended --installdir /opt/fortify --InstallSamples 0 --fortify_license_path ./fortify.license --UpdateServer https://fortify.synchronoss.com/ssc

# TODO install other c/c++ build systems, scons, sbuild, etc

# clean up tmp
RUN rm -rf /tmp/*

#update path vars
ENV PATH="/opt/fortify/bin:${PATH}"
ENV PATH="/opt/apache-maven/bin:${PATH}"

# set new work dir
WORKDIR /fortify
