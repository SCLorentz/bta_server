ARCH="macos-arm64"
mkdir -p "$(pwd)/.tmp"
cd "$(pwd)/.tmp"

if \
	[ -e "bta.v7.3.client.jar" ] \
	&& [ -e "legacy-lwjgl3-bta-1.0.6.jar" ] \
	&& [ -e "client.jar" ]; then
		echo "libraries already downloaded. Skipping"
else
	echo "downloading libraries..."
	cp ../scripts/pom.xml .
	mvn dependency:copy-dependencies -q
	find target/dependency -type f -name '*.jar' -exec mv {} . \;
	rm -rf target/dependency

	echo "dowloading minecraft..."
	for f in \
		https://github.com/Better-than-Adventure/bta-download-repo/releases/download/v7.3/bta.v7.3.client.jar \
		https://github.com/Better-than-Adventure/legacy-lwjgl3/releases/download/1.0.6/legacy-lwjgl3-bta-1.0.6.jar \
		https://launcher.mojang.com/v1/objects/43db9b498cb67058d2e12d394e6507722e71bb45/client.jar #!!!!
	do
		wget $f -q --show-progress
	done

	echo "unpacking libs..."
	mkdir natives

	for f in \
		lwjgl-3.3.6-natives-$ARCH.jar \
		lwjgl-opengl-3.3.6-natives-$ARCH.jar \
		lwjgl-stb-3.3.6-natives-$ARCH.jar \
		lwjgl-glfw-3.3.6-natives-$ARCH.jar \
		lwjgl-openal-3.3.6-natives-$ARCH.jar
	do
		[ -f "$f" ] && echo OK "$f" || echo MISSING "$f"
		unzip -n "$f" -d natives >> /dev/null
	done

	find natives -type f -name '*.dylib' -exec mv {} . \;
	rm -rf lwjgl/ natives/
fi
echo "starting minecraft..."
exec java -XstartOnFirstThread \
	-Djava.library.path="$(pwd)" \
	-cp "$(pwd)/client.jar:$(pwd)/bta.v7.3.client.jar:$(pwd)/legacy-lwjgl3-bta-1.0.6.jar:$(pwd)/lwjgl.jar:$(pwd)/lwjgl-glfw.jar:$(pwd)/lwjgl-opengl.jar:$(pwd)/lwjgl-openal.jar:$(pwd)/lwjgl-stb.jar" \
	net.minecraft.client.Minecraft