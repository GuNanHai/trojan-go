echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

wget -O web.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/web.zip
wget -O aria2c.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2c.zip
wget -O caddy.zip https://raw.githubusercontent.com/GuNanHai/offlineDown/master/caddy.zip
wget -O aria2.service https://raw.githubusercontent.com/GuNanHai/offlineDown/master/aria2.service
wget -O server.json https://raw.githubusercontent.com/GuNanHai/trojan-go/main/server.json
wget -O trojan.zip https://github.com/GuNanHai/trojan-go/blob/main/trojan-go-linux-amd64.zip
wget -O bysideen.crt   https://github.com/GuNanHai/trojan-go/blob/main/bysideen.crt   
wget -O bysideen.key   https://github.com/GuNanHai/trojan-go/blob/main/bysideen.key
wget -O trojan.service  https://github.com/GuNanHai/trojan-go/blob/main/trojan.service

sudo apt-get update
sudo apt-get -y install zip
sudo apt-get -y install aria2
sudo apt-get -y install unzip

unzip web.zip
mv web ~/
rm web.zip

unzip aria2c.zip
mv .aria2 ~/
rm aria2c.zip

unzip caddy.zip
mv caddy /usr/local/bin/
mv Caddyfile /usr/local/bin/
rm caddy.zip

mv aria2.service /etc/systemd/system/aria2.service
systemctl enable aria2.service && systemctl start aria2.service

ulimit -n 8192
caddy -conf /usr/local/bin/Caddyfile  & disown

unzip trojan.zip 
rm trojan.zip 
mkdir /usr/bin/trojango
chmod +x  trojan-go
mv trojan-go /usr/bin/trojango/trojan-go


mkdir /var/log/trojan
mv server.json /usr/bin/trojango/server.json
mv geoip.dat /usr/bin/trojango/geoip.dat
mv geosite.dat  /usr/bin/trojango/geosite.dat
mv trojan.service /etc/systemd/system/trojan.service
systemctl enable trojan.service
systemctl start trojan.service
