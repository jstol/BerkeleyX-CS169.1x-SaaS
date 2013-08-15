#!/bin/bash
rails server &>2 &
echo $! > .server.pid
