# fortify-docker
A docker container for running fortify on different platforms. This was made to normalize fortify translations accross multiple platforms. Each docker file is geared towards a specific translation target (e.g. java8, 11, c, c++, etc)
## Prereqs
Download the latest fortify sca from Microfocus and update the docker files with that binary name in the install step denoted with the comment `install fortify` in the dockerfiles.

## Building the image
Example
```bash
docker build . -t fortify:java8 -f java8.dockerfile
```

## Running a translation
```bash
# run container. Mount .m2 for maven credentials, .ssh for git ssh credentials
docker run -it --rm -v $HOME/.m2 -v `pwd`:/scan -v $HOME/.ssh foritfy:java8 /bin/bash
cd /scan

# fortify scan
sourceanalyzer -b <BUILD_ID> mvn install com.fortify.sca.plugins.maven:sca-maven-plugin:translate -DskipTests=true
```