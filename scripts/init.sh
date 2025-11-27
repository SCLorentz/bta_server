echo "init"
mkdir -p tmp
echo "downloading jd-cli..."
wget https://github.com/intoolswetrust/jd-cli/releases/download/jd-cli-1.3.0-beta-1/jd-cli-1.3.0-beta-1-dist.tar.gz -P ./tmp &> /dev/null
echo "extracting jd-cli..."
tar -xzf tmp/jd-cli-1.3.0-beta-1-dist.tar.gz -C tmp/
mv tmp/jd-cli.jar ./
rm -rf tmp
echo "decompiling server.jar..."
java -jar jd-cli.jar -od server server.jar &> /dev/null
echo "done!"