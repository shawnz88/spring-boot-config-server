# Spring Boot Config Server

## Objectives

* Setup Spring Boot Config Server
* Pull configurations from a git repository
* Authenticate to git repository using username/password
* Protect git repository password with encryption
* Protect access to Spring Boot Config Server with basic authentication
* Store secrets in git repository encrypted
* Optionally: protect access to Spring Boot Config Server with AD/Ldap credentials

## The CloudIDE

1. This repository has been authored and tested using Cloud9 IDE as PoC for an isolated environment
2. All the dependencies have been installed and encapsulated in the setup.sh script

## Development Setup on CentOS (tested on Cloud9 IDE)

1. [Original post](http://www.baeldung.com/spring-cloud-configuration)
1. Clone the repository
1. `cd` into the repository folder
1. Run the setup script:
```
chmod +x ./setup.sh && \
./setup.sh
```

## Where are the configurations are stored?

* Configuration are stored in a git [repository](../spring-boot-config-server-settings/readme.md)
* A sample configuration file: ./customerprofile.properties in a master branch:
```
# Sample configuration settings
spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/catalog
spring.datasource.username=dummy
spring.datasource.password=notreal
```
* To fetch the config: `curl -v -POST -H 'Authorization: Basic cm9vdDpzM2NyM3Q=' 'http://localhost:8080/encrypt' --data-urlencode dummyStringToEncrypt
`
* To encrypt a value: `curl -v -H 'Authorization: Basic cm9vdDpzM2NyM3Q=' localhost:8080/customerprofile/master`

## Where the secret is stored?

* Export environment variable: `export ENCRYPT_KEY=some-strong-secret`

## To run the service
```
export ENCRYPT_KEY=secret

./mvnw spring-boot:run
```

## To package the service:
```
./mvnw clean package
```

## To run the jar:
```
java -jar ./target/spring-boot-config-server-0.1.0.jar
```

## To test the end-point
```
curl http://localhost:8080/greeting
curl http://localhost:8080/greeting?name=User
```

## To deploy service to pcf:
```
cf login -a api.run.pivotal.io
cf push -n spring-boot-config-server -p ./target/spring-boot-config-server-0.1.0.jar   
```

## TODO:

* Actuator end-points are exposed inluding `/env` which would expose all secrets un-encrypted