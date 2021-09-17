#!/usr/bin/env bash

curl -X POST \
     -d  '{"query":"{jurisdiction(name:\"Idaho\") {id}}"}' \
     -H "X-API-KEY: $OPENSTATES_APIKEY" \
     -H 'Content-Type: application/json' \
     'https://openstates.org/graphql'
