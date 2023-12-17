#!/bin/bash

#shelcheck source=/bin/null
source helpers.sh
#shelcheck source=/bin/null
source highlevel.sh

databasesDir=Databases/

# Function definitions
function createDatabase() {  #exsist from groupName
    printMessage "Choose database name:"
    read -r databaseName
    if ! test -d "$databasesDir$databaseName"; then
        printMessage "Private database [y/n]"
        mkdir -p "$databasesDir$databaseName"
        private=$(readBooleanInput)
        printMessage "Creating '$databaseName' Database as $([ "$private" == true ] && echo "Private" || echo "Public")..."
        if ! test -d "$databaseName"; then
         createGroup "$databaseName"
        fi
        
        # Change group ownership of the database directory
        changeGroup "$databaseName" "$databasesDir$databaseName"
        if [[ "$private" == true ]]; then
            chmod 660 "$databasesDir$databaseName"
        fi
        if [[ "$private" == false ]]; then
            chmod 666 "$databasesDir$databaseName"
        fi
    else
        echo "Sorry, The existing '$databaseName' you want to create already exists"
    fi
}

function deleteDatabase() {
    ls -1
    printMessage "Choose database name:"
    read -r databaseName
    if test -d "$databaseName"; then
        if [ $(find "$databaseName" -maxdepth 1 | wc -l) -eq 1 ] && test -O "$databaseName" -o -G admin; then
            rm -r -i  "$databaseName"
            printMessage "Deleting Database..."
        else
            echo "Sorry, you do not have delete permissions or folder not empty "
        fi
    else
        echo "Folder does not exist."
    fi
}


function emptyDatabase() {
    ls -1
    printMessage "Choose the database you want to empty :"
    read -r databaseName
    if test -d "$databaseName"; then
        if test -n "$(find "$databaseName" -mindepth 1)" && test -O "$databaseName" -o admin; then
            printMessage "Are you sure you have emptied the database[Y/N] ?"
            read -r value
            if [ "$value" == "y" ]; then
                rm -r "/home/jaydaa/DataBase/$databaseName"
                printMessage "Emptying Database..."
            else
                exit 0
            fi
        fi
    else
        echo "Folder does not exist."
    fi
}

function quit() {
    printMessage "Goodbye" "green"
    exit 0
    # Your implementation here
}

# # create text file represt a table in csv format
# # first column define the Id
# # and the user select how many column in table
# function createTable() {

# }


function createTable(){
    ls -1
    printMessage "Choose the database in which you want to create a table: "
    read -r databaseName
    if test -d "$databaseName"; then
        if test -O "$databaseName" -o admin; then
            printMessage "Enter the table name: "
            read -r tableName
            printMessage "Enter the number of columns: "
            read -r colNumber
            printMessage "Enter column names: "
            a=0
            while [ $a -lt 3 ]
            do
                echo $a
                read -r colName
                a=`expr $a +1`
            done
        fi
    else
        echo "DataBase does not exist."
    fi
}
n=$1
function insertData()
{
    echo "Add new record"
    echo -n "Please enter the key: "
    read -r addKey
    sudo echo -n "$addKey : ">> $n
    echo -n "Please enter the value: "
    read -r addValue
    sudo echo "$addValue" | base64 >> $n
}

function deleteData()
{
    echo "Delete a record"
    echo -n "Please enter the Key:"
    read deleteKey
    sudo sed -i '/^'$deleteKey' :/d' $n
}

function updateData()
{
    echo "Update a record"
    echo -n "Please enter the key to edit: "
    read -r key
    echo -n "Please enter the new value: "
    read -r newValue
    newValue64=$(echo "$newValue" | base64)
    sudo sed -i 's/'"$key"' .*/'"$key"' : '"$newValue64"' /g' "$n"
    newValue64=$(echo "$newValue" | base64)
}
# sudo sed -i 's/'$key' .*/'$key' : '$newValue64' /g' $n

function backupDatabases()
{
    echo "Enter the backup name (with file extention .zip or .gz or .tar): "
    read backupName
    
    ext=${backupName#*.}
    case $ext in
        "zip")
            sudo zip "$backupName" "$1"
        ;;
        "gz")
            sudo gzip "$backupName" "$1"
        ;;
        "tar")
            sudo tar -c "$backupName" -f "$1"
        ;;
        *)
            return
            
    esac
}

function restoreDatabases()
{
    echo "Enter the restore name (with file extention .zip or .gz or .tar): "
    read -r restoreName
    
    ext=${restoreName#*.}
    case $ext in
        "zip")
            sudo zip "$restoreName" "$1"
        ;;
        "gz")
            sudo gzip "$restoreName" "$1"
        ;;
        "tar")
            sudo tar -c "$restoreName" -f "$1"
        ;;
        *)
            return
            
    esac
}