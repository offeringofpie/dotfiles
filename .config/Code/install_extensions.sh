#!/bin/bash
set -e
cat ~/.config/Code/extensions.txt | xargs -L1 code --install-extension