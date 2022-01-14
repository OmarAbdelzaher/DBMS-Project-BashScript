#!/bin/bash

function CreateDatabase {
    echo "Enter the Database Name:"
    read databaseName

    findRes=`find -name $databaseName 2>>/dev/null`

    if [ "./$databaseName" = "$findRes" ]
        then 
        echo "This Database name already exists"
    else
        mkdir $databaseName
        echo "$databaseName database is created successfully" 
    fi
}

function ListDatabase {
    dbs=`ls -A | wc -l`

    if [ $dbs -eq 0 ]
        then 
            echo "No Databases found"
    else
        ls -d */
    fi
}

function CreateTable {
    echo "Enter the Table Name:"
    read TableName
    flag=0

    createT_arr=(`ls`)
    for i in $(seq 1 ${#createT_arr[@]})
    do  
        if [ "${createT_arr[i-1]}" = "$TableName" ]
        then 
            echo "This table name already exists"
            flag=1
        fi
    done

    if [ $flag -ne 1 ]
    then
        touch $TableName
        echo "$TableName table is created successfully"
    fi
}

function listTables {
    listing=`ls | wc -l`
    if [ $listing -eq 0 ]
        then echo "No tables found"
    else ls
    fi  
}

function DropTable {
    echo "Enter the table you want to drop:"
    read TableName
    
    flag_d=0
    
    dropT_arr=(`ls`)
    for i in $(seq ${#dropT_arr[@]})
    do  
        if [ "${dropT_arr[i-1]}" = "$TableName" ]
        then
            flag_d=1
        fi
    done

    if [ $flag_d -eq 1 ]
    then
        rm $TableName
        echo "$TableName table is dropped"
    else
        echo "This table name doesn't exist"
    fi
}

function InsertIntoTable {
    echo "Enter the table you want to insert into:"
    read TableName
    # check if table exists
    echo "Enter the number of table columns:"
    read no_cols

    for i in $(seq $no_cols)
    do
        echo "Enter the name of column number $i:"
        read col_$i
        meta+= echo col_$i  
    done

    # echo $col_1
    
    echo $meta

    # echo "Enter the record values:"
    # read record

    # echo $record >> $TableName
}

function ConnectMenu {
    echo "Successfully connected to $DatabaseConnect database"
    echo "Connect Menu:"
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Go to Main Menu"
    do    
    case $choice in
        "Create Table" ) CreateTable ;;
        "List Tables" ) listTables ;;
        "Drop Table" ) DropTable ;;
        "Insert into Table" ) InsertIntoTable;;
        "Select From Table" ) echo Select ;;
        "Delete From Table" ) echo Delete ;;
        "Go to Main Menu" ) cd .. ; MainMenu ;;
        * ) echo $REPLY is not one of the choices ;;
    esac
    done
}

function ConnectDatabase {

    echo "Enter the Database you want to connect to:"
    read DatabaseConnect

    findRes=`find -name $DatabaseConnect`

    if [ "./$DatabaseConnect" = "$findRes" ] 
        then 
            cd $DatabaseConnect
            ConnectMenu
    else
        echo "This database doesn't exist"
    fi
}

function DropDatabase {
    echo "Enter the database you want to drop:"
    read DB
    
    findRes=`find -name $DB`

    if [ "./$DB" = "$findRes" ] 
        then
        echo "print yes or no to confirm droping"
            rm -Ir $DB  
    else
        echo "$DB database doesn't exist"
    fi
}

function MainMenu {
    cd DBMS
    echo "Main Menu:"
    select choice in "Create Database" "List Databases" "Connect to Databases" "Drop Database" "Exit"
    do    
    case $choice in
        "Create Database" ) CreateDatabase ;;
        "List Databases" ) ListDatabase ;;
        "Connect to Databases" ) ConnectDatabase ;;
        "Drop Database" ) DropDatabase ;;
        "Exit" ) exit ;;
        * ) echo $REPLY is not one of the choices ;;
    esac
    done
}

MainMenu
