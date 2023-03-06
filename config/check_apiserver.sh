#!/bin/sh
APISERVER_VIP=[VIRTUAL IP]
APISERVER_DEST_PORT=6443

exit() {
    echo "--- $* ---" 1>&2
    exit 1
}

if curl --silent --insecure https://localhost:${APISERVER_DEST_PORT}/ -o /dev/null 
    exit "Error GET https://localhost:${APISERVER_DEST_PORT}/"
fi

if ip addr | grep -q ${APISERVER_VIP}; then
    curl --silent --insecure https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/ -o /dev/null || exit "Error GET https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/"
fi
