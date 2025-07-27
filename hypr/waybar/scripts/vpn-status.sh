#!/bin/bash

if nmcli -t connection show --active | grep -q "client"; then
    echo "<span foreground='#FFFFFF'><b>●VPN</b></span>"
else
    echo "<span foreground='#BBBBBB'><b>○VPN</b></span>"
fi