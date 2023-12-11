#!/bin/bash

source helpers.sh

# Function definitions
function createDatabase() {
    printMessage "Choose database name:"
    read -r databaseName
    if ! test -d "$databaseName"; then
        printMessage "Private database [y/n]"
        mkdir $databaseName
        private=$(readBooleanInput)
        printMessage "Creating '$databaseName' Database as $([ "$private" == true ] && echo "Private" || echo "Public")..."
        if [[ "$private" == true ]]; then
            sudo chmod 700 $databaseName
            echo "Enter name group :"
            read nameGroup
            sudo chgrp $nameGroup $databaseName
        fi
        if [[ "$private" == false ]]; then
            sudo chmod 666 $databaseName
            echo "Enter name group :"
            read nameGroup
            sudo chgrp $nameGroup $databaseName
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
        if [ $(find $databaseName -maxdepth 1 | wc -l) -eq 1 ] && test -O $databaseName -o -G admin; then
            rm -r -i  $databaseName
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
    read -r $databaseName
    if test -d $databaseName; then
        if test -n "$(find $databasseName -mindepth 1)" && test -O $databaseName -o admin; then
            printMessage "Are you sure you have emptied the database[Y/N] ?"
            read $value
            if [ $value=="y" ]; then
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

function createTable(){
    ls -1
    printMessage "Choose the database in which you want to create a table: "
    read $databaseName
    if test -d $databaseName; then
        if test -O $databaseName -o admin; then
            printMessage "Enter the table name: "
            read $tableName
            printMessage "Enter the number of columns: "
            read $colNumber
            printMessage "Enter column names: "
            a=0
            while [ $a -lt 3 ]
            do
                echo $a
                read $colName
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
    read addKey
    sudo echo -n "$addKey : ">> $n
    echo -n "Please enter the value: "
    read addValue
    sudo echo $addValue | base64 >> $n
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
    read key
    echo -n "Please enter the new value: "
    read newValue
    newValue64=$(echo $newValue | base64)
    sudo sed -i 's/'$key' .*/'$key' : '$newValue64' /g' $n
    newValue64=$(echo $newValue | base64)
}
# sudo sed -i 's/'$key' .*/'$key' : '$newValue64' /g' $n

function backupDatabases()
{
    echo "Enter the backup name (with file extention .zip or .gz or .tar): "
    read backupName
    
    ext=${backupName#*.}
    case $ext in
        "zip")
            sudo zip $backupName $1
        ;;
        "gz")
            sudo gzip $backupName $1
        ;;
        "tar")
            sudo tar -c $backupName -f $1
        ;;
        *)
            break
            
    esac
}

function restoreDatabases()
{
    echo "Enter the restore name (with file extention .zip or .gz or .tar): "
    read restoreName
    
    ext=${restoreName#*.}
    case $ext in
        "zip")
            sudo zip $restoreName $1
        ;;
        "gz")
            sudo gzip $restoreName $1
        ;;
        "tar")
            sudo tar -c $restoreName -f $1
        ;;
        *)
            break
            
    esac
}