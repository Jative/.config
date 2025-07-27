#!/bin/bash

PROFILE="client"

if nmcli con show --active | grep -q "$PROFILE"; then
    nmcli con down id "$PROFILE"
else
    nmcli con up id "$PROFILE"
fi