#!/bin/bash
PID=$(cat .server.pid)
kill -9 $PID
