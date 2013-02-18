#!/bin/sh
rsync -av src/client/scripts/vendor build/client/scripts
rsync -av src/client/scripts/plugins build/client/scripts
mkdir build/client/scripts/views/templates/
rsync -av src/client/scripts/views/templates build/client/scripts/views
mkdir build/client/styles/assets/
mkdir build/client/styles/font/
rsync -av src/client/styles/font build/client/styles
rsync -av src/client/styles/assets build/client/styles
rsync -av src/server/views build/server
node server
