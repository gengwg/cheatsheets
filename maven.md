
super POM is maven default POM. all poms inherit from a parent or default. this base pom is known as the super pom, and contains values inherited by default.

maven uses the effective pom (configuration from super pom plus project configration) to execute relaven goal. it helps developers to specify miniumum configration detail in his pom.xml. although configration can be overriden easily.

to look at the default configurations of the super POM:

    mvn help:effective-pom


    mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

Suffice it to say for now that a plugin is a collection of goals with a general common purpose. For example the jboss-maven-plugin, whose purpose is "deal with various jboss items".

A phase is a step in the build lifecycle, which is an ordered sequence of phases. When a phase is given, Maven will execute every phase in the sequence up to and including the one defined. For example, if we execute the compile phase, the phases that actually get executed are:

1. validate
2. generate-sources
3. process-sources
4. generate-resources
5. process-resources
6. compile

```
$ java -cp target/redis-client-1.0-SNAPSHOT.jar com.mycompany.app.RedisClient
Exception in thread "main" java.lang.NoClassDefFoundError: redis/clients/jedis/JedisPoolConfig
    at com.mycompany.app.RedisClient.main(RedisClient.java:18)
Caused by: java.lang.ClassNotFoundException: redis.clients.jedis.JedisPoolConfig
    at java.net.URLClassLoader.findClass(URLClassLoader.java:381)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
    at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:331)
    at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
    ... 1 more
```
===>
```
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-shade-plugin</artifactId>
            <version>2.4</version>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>shade</goal>
                    </goals>
                    <configuration>
                        <transformers>
                            <transformer
                                implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                            </transformer>
                        </transformers>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

#### run a maven created jar file using just the command line

1st Step: Add this content in pom.xml
```
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-shade-plugin</artifactId>
            <version>2.1</version>
            <executions>
                <execution>
                    <phase>package</phase>
                    <goals>
                        <goal>shade</goal>
                    </goals>
                    <configuration>
                        <transformers>
                            <transformer
                                implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                            </transformer>
                        </transformers>
                    </configuration>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```
2nd Step : Execute this command line by line.
```
cd /go/to/myApp
mvn clean package
java -cp target/myApp-0.0.1-SNAPSHOT.jar go.to.myApp.select.file.to.execute
```

maven local repository gets created when you run any maven command for the first time.

Maven uses `archetype` plugins to create projects.
to create a simple java application, use `maven-archetype-quickstart` plugin.


clean: to clearn the target directory  
package: to package the project build output as jar

maven compiles the source code files, then tests the source code files  
then runs the test cases  
finally creates the package  

#### External Dependency
* external dependencies (library jar location) can be configured in pom.xml in same way as other dependencies
* specify groupId same as the name of the library
* specify artifactId same as the name of the library
* specify scope as system
* specify system path relative to the project location

example:
```
<dependency>
   <groupId>ldapjdk</groupId>
   <artifactId>ldapjdk</artifactId>
   <scope>system</scope>
   <version>1.0</version>
   <systemPath>${basedir}\src\lib\ldapjdk.jar</systemPath>
</dependency>
```
