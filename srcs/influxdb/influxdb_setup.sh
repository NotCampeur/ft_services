# influxd -config /etc/influxdb.conf
telegraf &
influxd run -config /etc/influxdb.conf