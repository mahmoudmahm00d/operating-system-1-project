#!/bin/bash

# Function to print with color
function printMessage() {
    local message="$1"
    local color="$2"
    
    case $color in
        "red")
            echo -e "\e[31m$message\e[0m"  # Red
        ;;
        "green")
            echo -e "\e[32m$message\e[0m"  # Green
        ;;
        "yellow")
            echo -e "\e[33m$message\e[0m"  # Yellow
        ;;
        "blue")
            echo -e "\e[34m$message\e[0m"  # Blue
        ;;
        "purple")
            echo -e "\e[35m$message\e[0m"  # Purple
        ;;
        "cyan")
            echo -e "\e[36m$message\e[0m"  # Cyan
        ;;
        "white")
            echo -e "\e[37m$message\e[0m"  # White
        ;;
        *)
            echo -e "\e[37m$message\e[0m"  # White
        ;;
    esac
}

# Example usage
# printMessage "This is a red message" "red"
# printMessage "This is a green message" "green"
# printMessage "This is a yellow message" "yellow"
# printMessage "This is a blue message" "blue"
# printMessage "This is a purple message" "purple"
# printMessage "This is a cyan message" "cyan"
# printMessage "This is a white message" "white"


checkLastOperationStatus() {
    if [ $? -eq 0 ]
    then
        echo "$1 completed successfully"
    else
        echo "$1 failed"
        exit 1
    fi
}

# Example usage
# checkLastOperationStatus "Opeation name"
# checkLastOperationStatus "sudo rm -rf /"

# Function to read a boolean input (y/n)
function readBooleanInput() {
    local input

    while true; do
        # Prompt user for input
        read -r input

        # Convert input to lowercase for case-insensitive comparison
        input=$(echo "$input" | tr '[:upper:]' '[:lower:]')

        # Check if input is valid
        if [[ "$input" == "y" ]]; then
            return 0  # True (Yes)
        elif [[ "$input" == "n" ]]; then
            return 1  # False (No)
        else
            printMessage "Invalid input. Please enter 'y' or 'n'." "red"
        fi
    done
}

# Example usage of the function
# echo "Do you want to continue?"
# if readBooleanInput; then
#     echo "You chose Yes."
# else
#     echo "You chose No."
# fi