mkdir -p tmp
cd tmp
if \
	[ -e "bta.v7.3.client.jar" ] \
	&& [ -e "legacy-lwjgl3-bta-1.0.6.jar" ]; then
		echo "libraries already downloaded. Skipping"
else
	echo "downloading resources (this may take a while)..."
	wget https://github.com/Better-than-Adventure/bta-download-repo/releases/download/v7.3/bta.v7.3.client.jar \
	https://github.com/Better-than-Adventure/legacy-lwjgl3/releases/download/1.0.6/legacy-lwjgl3-bta-1.0.6.jar \
	https://launcher.mojang.com/v1/objects/43db9b498cb67058d2e12d394e6507722e71bb45/client.jar \
	https://github.com/LWJGL/lwjgl3/releases/download/3.3.6/lwjgl-3.3.6.zip &> /dev/null
	echo "unpacking libs..."
	mkdir -p lwjgl
	unzip lwjgl-3.3.6.zip -d lwjgl/ >> /dev/null
	mv \
		lwjgl/lwjgl/lwjgl.jar \
		lwjgl/lwjgl/lwjgl-natives-macos-arm64.jar \
		lwjgl/lwjgl-opengl/lwjgl-opengl.jar \
		lwjgl/lwjgl-opengl/lwjgl-opengl-natives-macos-arm64.jar \
		lwjgl/lwjgl-stb/lwjgl-stb.jar \
		lwjgl/lwjgl-stb/lwjgl-stb-natives-macos-arm64.jar \
		lwjgl/lwjgl-glfw/lwjgl-glfw.jar \
		lwjgl/lwjgl-glfw/lwjgl-glfw-natives-macos-arm64.jar \
		lwjgl/lwjgl-openal/lwjgl-openal.jar \
		lwjgl/lwjgl-openal/lwjgl-openal-natives-macos-arm64.jar \
		./
	rm -rf lwjgl/
	echo "extracting natives..."
	unzip -o lwjgl-natives-macos-arm64.jar -d natives
	unzip -o lwjgl-glfw-natives-macos-arm64.jar -d natives
	unzip -o lwjgl-opengl-natives-macos-arm64.jar -d natives
	unzip -o lwjgl-stb-natives-macos-arm64.jar -d natives
	unzip -o lwjgl-openal-natives-macos-arm64.jar -d natives
	mv ./natives/**/*.dylib ./
	rm -rf natives/
fi
echo "starting minecraft..."
exec java -XstartOnFirstThread \
	-Djava.library.path="$(pwd)" \
	-cp "$(pwd)/client.jar:$(pwd)/bta.v7.3.client.jar:$(pwd)/legacy-lwjgl3-bta-1.0.6.jar:$(pwd)/lwjgl.jar:$(pwd)/lwjgl-glfw.jar:$(pwd)/lwjgl-opengl.jar:$(pwd)/lwjgl-openal.jar:$(pwd)/lwjgl-stb.jar" \
	net.minecraft.client.Minecraft
