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
	mvn --log-file ./mvn.log dependency:copy-dependencies &> /dev/null || {
		echo "Something went wrong while using maven. Check the logs in $(pwd)/mvn.log"
	}
	find target/dependency -type f -name '*.jar' -exec mv {} . \;
	rm -rf target pom.xml
	echo "done!"

	echo "dowloading bta..."
	for f in \
		https://github.com/Better-than-Adventure/bta-download-repo/releases/download/v7.3/bta.v7.3.client.jar \
		https://github.com/Better-than-Adventure/legacy-lwjgl3/releases/download/1.0.6/legacy-lwjgl3-bta-1.0.6.jar \
		https://piston-meta.mojang.com/mc/game/version_manifest.json
	do
		wget $f -q --show-progress
	done

	# https://jqlang.org/manual/#builtin-operators-and-functions
	echo "reading piston-meta.mojang.com"
	wget $(cat version_manifest.json | jq -r '.versions[] | select(.id == "b1.7.3").url') -q --show-progress
	wget $(cat b1.7.3.json | jq -r '.downloads.client.url') -q --show-progress
	
	rm -rf b1.7.3.json version_manifest.json

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
echo "starting minecraft...\n"
exec java -XstartOnFirstThread \
	-Djava.library.path="$(pwd)" \
	-cp "$(pwd)/client.jar:$(pwd)/bta.v7.3.client.jar:$(pwd)/legacy-lwjgl3-bta-1.0.6.jar:$(pwd)/lwjgl.jar:$(pwd)/lwjgl-glfw.jar:$(pwd)/lwjgl-opengl.jar:$(pwd)/lwjgl-openal.jar:$(pwd)/lwjgl-stb.jar" \
	net.minecraft.client.Minecraft