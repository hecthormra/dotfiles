#!/bin/sh

# mata serviços antigos de áudio
pkill dbar
pkill mako
pkill wireplumber
pkill pipewire-pulse
pkill pipewire

sleep 1

# inicia áudio
pipewire &
sleep 1

wireplumber &
sleep 1

pipewire-pulse &

sleep 3

# inicia dbar
/home/hecthor/.local/bin/dbar > /tmp/dbar.log 2>&1 &

# inicia notificações
pkill mako
mako &

# Corrige o mixer depois de todos os serviços
sleep 2
amixer -c 0 sset Front unmute

# Iniciar polkit gnome 
if ! pgrep -f polkit-gnome-authentication-agent-1 >/dev/null 2>&1; then
    /usr/libexec/polkit-gnome-authentication-agent-1 &
fi
