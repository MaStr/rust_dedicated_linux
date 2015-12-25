#!/bin/sh

## Create a copy for each your instance

## Remote Administration Options
rcon_ip="0.0.0.0"  
rcon_port=28016     # This port is TCP
rcon_password="yourPassword"

## Server configuration
server_hostname="my Server"
server_port="28015" # This port is UDP
server_identity="identity"
server_maxplayers="100"
server_level="Procedural Map" # Don't change
server_url=""    # URL displayed at login screen
server_description=""  # Description displayed while login
server_seed="nnnnnn"   # Replace with a random number

# InGame variables
decay_scale=1          # 1 = Decay player buildings afert certain amount
                       #     of time
                       # 0 = Buildings last until reset          


logfile="${server_identity}_output.txt"

#Save last Logfile
mv ~/Server/rustds/${logfile} ~/Server/rustds/${logfile}.old

export WINEARCH=win64 
export WINEPREFIX=/home/rust/.wine64

cd ~/Server/rustds
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' \
	wine  RustDedicated.exe \
		-load  \
		-batchmode \
		-logFile $logfile \
		-autoupdate \
		+rcon.ip "${rcon_ip}" \
		+rcon.port "${rcon_port}" \
		+rcon.password "${rcon_password}" \
		+server.hostname "${server_hostname}" \
		+server.port "${server_port}" \
		+server.identity "${server_identity}" \
		+server.maxplayers "${server_maxplayers}" \
		+server.level "${server_level}"  \
		+server.url "${server_url}"  \
		+server.description "${server_description}" \
		+server.seed "${server_seed}"  \
		+decay.scale "${decay_scale}" 

## -load       => Loads a previously saved map (same seed needed)
## -batchmode  => ??
## -logFile    => Writes server output to a txt file
## -autoupdate => Perform server updates if needed 
