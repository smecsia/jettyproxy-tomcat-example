#!/bin/bash
cp -f /webapps/ROOT.war /opt/tomcat/webapps/ROOT.war
cat <<-EOF > /opt/tomcat/conf/catalina.policy
    grant {
        permission java.security.AllPermission;
    };
EOF

/usr/bin/java \
    -Djava.util.logging.config.file=/opt/tomcat/conf/logging.properties \
    -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager \
    -Dsecurerandom.source=file:/dev/./urandom \
    -Djava.security.egd=file:/dev/./urandom \
    -Djava.endorsed.dirs="/opt/tomcat/endorsed" \
    -classpath /opt/tomcat/bin/bootstrap.jar:/opt/tomcat/bin/tomcat-juli.jar \
    -Djava.security.manager \
    -Djava.security.policy=/opt/tomcat/conf/catalina.policy \
    -Dcatalina.base="/opt/tomcat" \
    -Dcatalina.home="/opt/tomcat" \
    -Djava.io.tmpdir="/opt/tomcat/temp" \
    -Xrunjdwp:transport=dt_socket,address=5005,server=y,suspend=n \
    org.apache.catalina.startup.Bootstrap start