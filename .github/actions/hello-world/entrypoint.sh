#!/usr/bin/env bash

echo "In Action!"
echo $1
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT