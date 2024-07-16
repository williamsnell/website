#!/bin/bash

cd /hexchess/frontend
./build.sh

cd /hexchess/server
cargo run -r

