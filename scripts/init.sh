echo "init"
mkdir -p .tmp
echo "downloading jd-cli..."
wget https://github.com/intoolswetrust/jd-cli/releases/download/jd-cli-1.3.0-beta-1/jd-cli-1.3.0-beta-1-dist.tar.gz -P ./.tmp -q --show-progress
echo "extracting jd-cli..."
tar -xzf .tmp/jd-cli-1.3.0-beta-1-dist.tar.gz -C .tmp/
mv .tmp/jd-cli.jar ./
echo "downloading server.jar"
wget -O server.jar https://github.com/Better-than-Adventure/bta-download-repo/releases/download/v7.3/bta.v7.3.server.jar -q --show-progress
echo "decompiling server.jar..."
java -jar jd-cli.jar -od server server.jar &> /dev/null
echo "done!"