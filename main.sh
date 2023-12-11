#!/bin/bash

source helpers.sh
source functions.sh
source menus.sh

stage=0
loop=true

function printStage() {
    case $stage in
        0)
            printMainMenu
        ;;
        *)
        ;;
    esac
}

function changeStage() {
    stage=$1
}

# Main script
while $loop; do
    printStage
    printMessage ">" "green"
    read -r choice
    # Use a case statement to call the corresponding function
    case $choice in
        1)
            changeStage 1
            createDatabase
            changeStage 0
        ;;
        2) deleteDatabase ;;
        3) emptyDatabase ;;
        4) createTable ;;
        "q") quit ;;
        # Add more cases for other options...
        *)
            printMessage "Invalid option. Please select a number from 1 to 12." "red"
        ;;
    esac
done