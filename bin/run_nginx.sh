#!/bin/sh
echo "shell"

GPIO=23
PUSHTIME=2

# set attribute
echo "$GPIO" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio$GPIO/direction
echo "high" > /sys/class/gpio/gpio$GPIO/direction

# count
cnt=0
while [ $cnt -lt $PUSHTIME ] ; do
  data=`cat /sys/class/gpio/gpio$GPIO/value`

  if [ "$data" -eq "0" ] ; then
    cnt=`expr $cnt + 1`
  else
    cnt=0
  fi
                        
  sleep 1
done

echo "docker run!"
docker run -it -p 8080:80 bouzuao/nginx-raspbian:install_supervisor /usr/bin/supervisord
