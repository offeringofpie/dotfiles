#!/bin/bash
rm ~/Library/Application\ Support/Code/User/settings.json
rm ~/Library/Application\ Support/Code/User/keybindings.json
rm ~/Library/Application\ Support/Code/User/snippets/
ln -s ~/.config/Code/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.config/Code/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.config/Code/snippets/ ~/Library/Application\ Support/Code/User
./install_extensions.sh