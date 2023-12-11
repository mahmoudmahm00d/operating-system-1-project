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
			    printMessage "Creating '$databaseName' Database as $([ "$private" == "true" ] && echo "Private" || echo "Public")..."
            else
            echo "Sorry, The existing '$databaseName' you want to create already exists"
			        # Your implementation here
                    fi
}

			function deleteDatabase() {
				ls -1
				printMessage "Choose database name:"
				read -r databaseName
				if test -d $databaseName; then
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
						        rm -ri "/home/jaydaa/DataBase/$databaseName"
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
