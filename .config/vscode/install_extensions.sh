#!/bin/bash
set -e
cat ~/.config/vscode/extensions.txt | xargs -L1 code --install-extension