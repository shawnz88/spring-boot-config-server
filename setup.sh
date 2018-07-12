sudo yum install zip && \
# Install Java 8
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u74-b02/jdk-8u74-linux-x64.rpm"
sudo yum -y localinstall jdk-*.rpm
rm -fR jdk-*.rpm
sudo /usr/sbin/alternatives --config java
# select the number corresponding to  /opt/jdk1.8.0_171/bin/java

# install JCE 8
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
unzip jce_policy-8.zip

sudo mv /usr/java/default/jre/lib/security/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar.backup
sudo mv /usr/java/default/jre/lib/security/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar.backup
sudo mv UnlimitedJCEPolicyJDK8/*.jar /usr/java/default/jre/lib/security/
rm -f jce_policy-8.zip

sudo echo 'export JAVA_HOME="/usr/java/default"' >> ~/.bashrc && \
source ~/.bashrc && \
# Install Maven
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo && \
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo && \
sudo yum install -y apache-maven && \
mvn --version
# Install pcf-cli
sudo yum update -y && \
sudo wget -O /etc/yum.repos.d/cloudfoundry-cli.repo https://packages.cloudfoundry.org/fedora/cloudfoundry-cli.repo && \
sudo yum install cf-cli -y && \
cf --version
