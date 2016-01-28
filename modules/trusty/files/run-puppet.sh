#!/bin/bash

sleepSeconds=$((RANDOM % 900))
sleep $((RANDOM % sleepSeconds))

if [ -f '/opt/vagrant_ruby/bin/puppetd' ] 
then
  /opt/vagrant_ruby/bin/puppetd -tv # agent --onetime --no-daemonize --no-splay "$@"
else
 puppetd -tv 
fi
