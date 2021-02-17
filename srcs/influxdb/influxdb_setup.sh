# influxd -config /etc/influxdb.conf
telegraf --config /etc/telegraf.conf &
influxd run -config /etc/influxdb.conf