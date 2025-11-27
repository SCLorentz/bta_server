# Minecraft BTA with friends

This is my own minecraft server on my favorite minecraft version, b1.7.3 with one of my favorite mods. I plan to use this to play with friends and nothing more. I like to have full control of what I'm doing (with a bit of perfectionism), so I will use this repo instead of the generic `shockbyte` server that my friends opt to use. But I still need to find a good host platform with support for docker deploy and a good pricing, maybe hostinger, idk. Maybe connect a matrix server inside the java server to create an virtual chat inside the game???

## Info

The server of BTA is beeing modified to provide better control and optimizations for my usage intent. To open the original/modified server.jar file I'm using jd-cli-0.9.2 on graalvm. THE SOURCE CODE OF THE MODIFIED SERVER IS NOT AVALIABLE. As an extra, while building the server, we could try using the native-image from graalvm to generate a compiled version of the program.

There is an WARNING on execution `sun.reflect.Reflection.getCallerClass is not supported. This will impact performance.`, this warning comes from the file located in `server.jar/org/apache/logging/log4j/util/StackLocator.java`. Idealy we should use the latest verion of the lib `https://logging.apache.org/log4j/2.x/download.html`, but keep an eye on bugs and compatibility.

## Commands

you might find useful:

```fish
podman compose build
```

```fish
podman compose up -d
```

```fish
java -jar jd-cli-0.9.2-dist/jd-cli.jar -od server server.jar
```

<img width="1708" height="960" alt="image" src="images/b.heic" />
