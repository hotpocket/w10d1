#!/bin/bash
echo "Welcome to the Bash Scripting Practice!"
echo "Please enter your name: "
read username
echo "Hello, $username! Welcome to the world of Bash scripting."
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current date and time: $current_datetime"