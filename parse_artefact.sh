#!/bin/bash

file=./artefact.json
transform='.artefact[]'
images="$(jq -cr "$transform" "$file" | tr '\n' ' ' | sed -e 's/https\?:\/\///g')"

echo $images