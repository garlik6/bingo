#!/bin/bash

URL="localhost:28914"

check_http() {
    response=$(curl -sS --max-time 5 -o /dev/null -w "%{http_code}" "$URL")
    if [ "$response" != "200" ]; then
        echo "HTTP check failed with status code $response"
        restart_process
    else
        echo "HTTP check passed (Status Code: $response)"
    fi
}

restart_process() {
    timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] restarting bingo"
    systemctl restart bingo
}

check_http
