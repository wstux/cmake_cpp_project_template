#!/bin/bash

if [[ -z "$1" ]]; then
    exit 1
fi

bin_path="$1/bin/executable"

$bin_path
if [[ $? -ne 0 ]]; then
    exit 1
fi

exit 0
