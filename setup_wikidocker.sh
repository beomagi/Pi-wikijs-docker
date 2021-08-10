#install docker
installdocker() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  #add pi user to docker group
  sudo usermod -aG docker pi
}
type docker || installdocker

#make folder
mkdir /home/pi/wikidocker
cd /home/pi/wikidocker

config='port: 3000
db:
  type: sqlite
  ssl: false
  storage: /wiki/ggnotes.sqlite 
bindIP: 0.0.0.0
logLevel: info
offline: false
ha: false
dataPath: ./data'
echo "$config" > wikidocker.conf

docker run -d -p 8080:3000 --name GiaWiki \
           --restart unless-stopped -e "DB_TYPE=sqlite" \
	   -e "DB_FILEPATH=/home/pi/wikidocker/ggnotes.sqlite" \
           -v /home/pi/wikidocker/wikidocker.conf:/wiki/config.yml \
	   -v /home/pi/wikidocker/ggnotes.sqlite:/wiki/ggnotes.sqlite \
           requarks/wiki:2


