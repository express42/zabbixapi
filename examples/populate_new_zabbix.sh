#!/bin/bash

if [ $# -ne 1 ]; then
  echo "usage: $(basename $0) ENVIRONMENT"
  exit 1
fi

ENVIRONMENT=$1
CURRENT_DIR=$(dirname $0)

# Clear default
bundle exec ruby zabbix_clear_default -E $ENVIRONMENT

# Availability
bundle exec ruby zabbix_availability -E $ENVIRONMENT -g "Templates"

# Net
bundle exec ruby zabbix_net -E $ENVIRONMENT -g "Templates" -i eth0
bundle exec ruby zabbix_net -E $ENVIRONMENT -g "Templates" -i eth1
bundle exec ruby zabbix_net -E $ENVIRONMENT -g "Templates" -i eth2
bundle exec ruby zabbix_net -E $ENVIRONMENT -g "Templates" -i eth3

# LA
bundle exec ruby zabbix_la -E $ENVIRONMENT -g "Templates"

# Memory
bundle exec ruby zabbix_memory -E $ENVIRONMENT -g "Templates"

# Filesystems
for i in "/storage" "/" "/boot" "/mnt" "/var" "/home" "/tmp" "/backup" \
  "/var/lib/postgresql"; do
  bundle exec ruby zabbix_filesystem -E $ENVIRONMENT -g "Templates" -m "$i"
done

# SSH
bundle exec ruby zabbix_ssh -E $ENVIRONMENT -g Templates

# NTP
bundle exec ruby zabbix_ntp -E $ENVIRONMENT -g Templates

# HLSP
for i in {1..8}; do
  bundle exec ruby zabbix_hlsp -E $ENVIRONMENT -g Templates -i ${i}
done

# Playout
bundle exec ruby zabbix_playout-t -E $ENVIRONMENT -g Templates 

# Voting Site
for i in {1..6}; do
  bundle exec ruby zabbix_voting-broadcast-site -E $ENVIRONMENT -g Templates -i ${i}
done

# MegaRAID
bundle exec ruby zabbix_megaraid -E $ENVIRONMENT -g Templates

# PGSQL
bundle exec ruby zabbix_pgsql -E $ENVIRONMENT -g Templates

# MDADM
for i in md0 md1 md2 md3; do
  bundle exec ruby zabbix_mdadm -E $ENVIRONMENT -g Templates -n ${i}
done

# ipmi_systemp
bundle exec ruby zabbix_ipmi_systemp -E $ENVIRONMENT -g Templates

# IO
bundle exec ruby zabbix_iops -E $ENVIRONMENT -g Templates -n sda

# varnish
bundle exec ruby zabbix_varnish -E $ENVIRONMENT -g Templates

# vmod_ele_cfg
bundle exec ruby zabbix_vmod_ele_cfg -E $ENVIRONMENT -g Templates

# nginx
bundle exec ruby zabbix_nginx -E $ENVIRONMENT -g Templates

# nginx_500
bundle exec ruby zabbix_nginx_500 -E $ENVIRONMENT -g Templates


bundle exec ruby zabbix_cpufan-sersor  -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_cputemp-sersor -E $ENVIRONMENT -g Templates
#bundle exec ruby zabbix_disk_io -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_ipmi-cpufan-sersor -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_mailer -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_megaraid -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_mpeg2lander_signal -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_mpeg2lander_status -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_named -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_nv-gputemp -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_alloc_bufsize -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_dropframes -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_missframes -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_play_status -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_status -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_uptime -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_player_used_bufsize -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_server_process -E $ENVIRONMENT -g Templates
bundle exec ruby zabbix_smart_blade -E $ENVIRONMENT -g Templates
#bundle exec ruby zabbix_videomute -E $ENVIRONMENT -g Templates
