#!/bin/bash

# Start supervisord and services
/usr/local/bin/supervisord -n -c /etc/supervisord.conf
