## Example of how to launch Jetty Proxy Servlet within Tomcat8

### Requirements

* JDK >= 1.8
* Maven >= 3.2
* Docker >= 1.7
* DockerCompose >= 1.5.1

### Launch

Start your proxy servlet with the following command:
```bash
$ mvn clean package exec:exec
```

Start logs tailing via:
```bash
$ docker exec -it proxy-servlet tail -f /opt/tomcat/logs/localhost.`date +%Y-%m-%d`.log
```

Then configure your browser to use proxy at localhost:8080 and see logs of each proxied request.

