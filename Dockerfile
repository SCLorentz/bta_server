FROM container-registry.oracle.com/graalvm/jdk:25
WORKDIR /app
VOLUME /app

COPY server.jar				/app/server.jar
COPY datapacks/				/app/datapacks/
COPY server.properties		/app/server.properties
COPY white-list.txt		/app/white-list.txt

EXPOSE 25565

CMD ["java", "-XX:+UseG1GC", "-XX:MaxGCPauseMillis=150", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:+UseStringDeduplication", "-XX:+UseAES", "-XX:+UseFMA", "-XX:+DoEscapeAnalysis", "-XX:+UseCodeCacheFlushing", "-XX:+OptimizeStringConcat", "-XX:+OmitStackTraceInFastThrow", "-Djdk.graal.CompilerConfiguration=community", "-Dsun.awt.noerasebackground=true", "-Dawt.useSystemAAFontSettings=on", "-Dsun.java2d.opengl=true", "-Dsun.java2d.renderer=opengl", "-jar", "/app/server.jar", "--nogui"]