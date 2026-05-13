#!/usr/bin/env bash
# Wait a second for Noctalia to finish writing the files
sleep 1 

# Reload GTK Apps instantly
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
sleep 0.1
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

# Reload Qt Apps (like Dolphin) instantly
# NOTE: Replace "KvDark" with whatever Noctalia's Kvantum theme folder is actually named!
kvantummanager --set "KvDark"