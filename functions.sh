#!/bin/bash

source helpers.sh

# Function definitions
function createDatabase() {
    printMessage "Choose database name:"
    read -r databaseName
    printMessage "Private database [y/n]"
    private=$(readBooleanInput)
    printMessage "Creating '$databaseName' Database as $([ "$private" == true ] && echo "Private" || echo "Public")..."
    # Your implementation here
}

function deleteDatabase() {
    printMessage "Deleting Database..."
    # Your implementation here
}

function emptyDatabase() {
    printMessage "Emptying Database..."
    # Your implementation here
}

function quit() {
    printMessage "Goodbye" "green"
    exit 0
    # Your implementation here
}