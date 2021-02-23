#!/bin/sh

mkdir /etc/telegraf
cp /telegraf/telegraf /bin
cp telegraf.conf /etc/telegraf
cp telegraf.conf /telegraf
telegraf