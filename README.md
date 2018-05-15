# Luzifer / rust-server

This repository contains a Docker setup for [Linux Game Server Managers](https://gameservermanagers.com/) [Rust](http://playrust.com/) management script.

## How to use

- Choose a directory which will be used to persist downloaded gameserver data, maps, player data, ... (Needs ~6GB disk-space)  
  This README will use `/data/rust` as chosen directory. So replace that one with your choice in all commands.
- Execute `chown 1000:1000 /data/rust` to enable the unprivileged user in the container to write into that directory
- Do a first installation of the server: (This will require quite a time as it downloads a 5.8GB gameserver)  
  `docker run --rm -ti -v /data/rust:/home/rustserver --name rust luzifer/rust-server auto-install`
- Edit `/data/rust/rustserver` script and exchange RCON password and other configuration variables
- Edit `/data/rust/serverfiles/server/rust-server/cfg/server.cfg` and set the description, image and URL of your server
- Start your server:
    ```
    docker run -d -p 28015:28015/udp -p 28016:28016 \
              -v /data/rust:/home/rustserver --name rust \
              luzifer/rust-server start
    ```
- To stop the server I recommend using the RCON console and the command `quit`. This will ensure the server has created a proper savegame.
- To update the server stop it and afterwards execute the update:  
  `docker run --rm -ti -v /data/rust:/home/rustserver luzifer/rust-server update`

