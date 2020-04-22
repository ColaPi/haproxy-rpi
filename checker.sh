#!/bin/sh
/usr/bin/httpget -s $3 -p $4 -k balancing -m aes-256-cfb -nr 2 https://www.google.com/ncr