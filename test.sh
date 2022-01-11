function ListDatabase {
    listDB_arr=(`ls DBMS`)
    # echo ${listDB_arr[@]}

    for i in $(seq ${#listDB_arr[@]})
    do
        if [ -d /${listDB_arr[i-1]} ]
            then ls DBMS
            break
        else
            echo "No Databases found"
        fi
    done
}