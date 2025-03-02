# The Lord of the Rings: Return to Moria Dedicated Server using Wine

The official dedicated servers only support Windows. But I like Docker. I like to be able host a game on my NAS without having to have my gaming pc running all the time.

Uses steamcmd to keep server updated on container startup.

How to use this container
- download MoriaServerConfig.ini, MoriaServerPermissions.txt and MoriaServerRules.txt from this repository.
- set up container in docker, example shown below

## Docker cli example

```bash
docker run -d --name='moria-server' \
--net='bridge' \
--restart=unless-stopped \
-v 'MoriaServerConfig.ini':'/moriaserver/MoriaServerConfig.ini':'rw' \
-v 'MoriaServerPermissions.txt':'/moriaserver/MoriaServerPermissions.txt':'rw' \
-v 'MoriaServerRules.txt':'/moriaserver/MoriaServerRules.txt':'rw' \
-v 'saves/':'/moriaserver/Moria/Saved/SaveGamesDedicated/' \
-p 7777:7777/udp \
'tojnk/moria-server'
```

Known issues
- During testing I ran into an issue that caused the savegame to be corrupted after restarting. Maybe the server doesn't shutdown cleanly.


I was inspired by the following repositories:
- https://github.com/lloesche/valheim-server-docker/
- https://github.com/TrueOsiris/docker-vrising
