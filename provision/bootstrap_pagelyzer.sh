###
# Install pagelyzer
###

echo "Installing Pagelyzer"


echo "install firefox"
sudo apt-get install firefox
echo "install xvfb"
sudo apt-get install xvfb


cd /vagrant/pagelyzer


# path for js files 
export pjs="\/vagrant\/pagelyzer\/SettingsFiles\/js\/"
# path for config folder ext
export pext="\/vagrant\/pagelyzer\/SettingsFiles\/ext\/"
# to save images to show at demo
mkdir tmp
export ptmp="\/vagrant\/pagelyzer\/tmp\/"


#replace string in config files

for configfile in ./config_*.xml
do
	sed -i "s/PATH_JS/$pjs/g" $configfile
	sed -i "s/PATH_EXT/$pext/g" $configfile
	sed -i "s/PATH_TMP/$ptmp/g" $configfile
done

sed -i "s/PATH_TMP/$ptmp/g" index.html

echo "copy pagelyzer jar file"
wget http://scape.lip6.fr/scape-demo-sites/pagelyzer/Pagelyzer-0.0.1-SNAPSHOT-jar-with-dependencies.jar
echo "copy selenium jar file"
wget http://selenium.googlecode.com/files/selenium-server-standalone-2.39.0.jar

echo "Running selenium server"
#Running selenium server 
Xvfb :2 -screen 0 1024x768x24 &
DISPLAY=:2 java -jar selenium-server-standalone-2.39.0.jar -port 8015 &
#Create screen to run pagelyzer 
Xvfb :1 -screen 0 1024x768x24 &

