#!/bin/bash

function printMainMenu() {
    # Display the options
    printMessage "============================" "blue"
    printMessage "Select an operation (1-12):"
    printMessage "1) Create a Database"
    printMessage "2) Delete a Database"
    printMessage "3) Empty a Database"
    printMessage "4) Create tables."
    printMessage "5) Delete tables"
    printMessage "6) Update tables"
    printMessage "7) Insert data"
    printMessage "8) Delete data"
    printMessage "9) Retrieve data"
    printMessage "10) Backup Databases"
    printMessage "11) Restore Databases"
    printMessage "12) Logs Databases"
    printMessage "q) Quit"
}

# Add other menus here...