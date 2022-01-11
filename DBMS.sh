#!/bin/bash

function CreateDatabase {
    echo "Enter the Database Name:"
    read databaseName

    # find command throw error no such file or directory
    findRes=`find DBMS/$databaseName -name $databaseName`

    if [ "DBMS/$databaseName" = "$findRes" ]
        then 
        echo "This Database name already exists"
    else
    {
        mkdir DBMS/$databaseName
        echo "$databaseName database is created successfully"
    }    
    fi
}

function ListDatabase {
    for databases in "DBMS"/*
    do
        if [ -d $databases ]
            then ls DBMS
            break
        else
            echo "No Databases found"
        fi
    done
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

function DropTable {
    echo "Enter the table you want to drop:"
    read TableName
    dropT_arr=(`ls`)
    for i in $(seq ${#dropT_arr[@]})
    do  
        if [ "${dropT_arr[i-1]}" = "$TableName" ]
        then
            rm $TableName
            echo "$TableName table is dropped"
            break
        else
            echo "This table doesn't exist"
        fi
    done
}

function InsertTable {
    echo "Enter the table you want to insert into:"
    read TableName

    echo "Enter the record values:"
    read record

    echo $record >> $TableName
}

function ConnectMenu {
    echo "Successfully connected to $DatabaseConnect database"
    echo "Connect Menu:"
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Go to Main Menu"
    do    
    case $choice in
        "Create Table" ) CreateTable ;;
        "List Tables" ) ls ;;
        "Drop Table" ) DropTable ;;
        "Insert into Table" ) InsertTable;;
        "Select From Table" ) echo Select ;;
        "Delete From Table" ) echo Delete ;;
        "Go to Main Menu" ) MainMenu ;;
        * ) echo $REPLY is not one of the choices ;;
    esac
    done
}


function ConnectDatabase {
    # cd ./D
    echo "Enter the Database you want to connect to:"
    read DatabaseConnect

    findRes=`find $DatabaseConnect -name $DatabaseConnect`

    if [ "$DatabaseConnect" = "$findRes" ] 
        then 
            cd $DatabaseConnect
            echo $PWD
            ConnectMenu
    else
    {
        echo "This database doesn't exist"
    }    
    fi
}

function DropDatabase {
    echo "Enter the database you want to drop:"
    read DB
    
    findRes=`find DBMS/$DB -name $DB`

    if [ "DBMS/$DB" = "$findRes" ] 
        then
        echo "print yes or no to confirm droping"
            rm -Ir DBMS/$DB  
    else
        echo "$DB database doesn't exist"
    fi
}

function MainMenu {
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
