#!/bin/bash

# update server
steamcmd +force_install_dir /moriaserver +login anonymous +app_update 3349480 +quit

Xvfb :0 -screen 0 1024x768x16 &
DISPLAY=:0.0 wine VC_redist.x64.exe /install /quiet
DISPLAY=:0.0 wine /moriaserver/MoriaServer.exe
tail -f /dev/null