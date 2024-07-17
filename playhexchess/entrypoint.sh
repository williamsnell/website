#!/bin/bash

cd /hexchess/frontend
npm install
npm run build


cd /hexchess/server
cargo run -r &

cd /hexchess/frontend
node build/index.js &

nginx -g 'daemon off;'
