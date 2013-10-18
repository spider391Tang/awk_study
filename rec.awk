awk '
BEGIN { "date" | getline
        printf("%s %s %s\n", $6,$2,$3);
        printf("ID Number Arrival Time\n") 
        printf("======================\n")
}

{ 
    arrival = HM_to_M( substr( $2, 1, length($2) - 3 ), 
            substr( $2, length($2) - 1 ) )

    total += arrival
    printf("%9d %12s %s \n", $1,$2, arrival > 480 ? "*" : "") | "sort"   # only execute 1 sort time 
}

END {
    close("sort")  # close pipe to force flush
    printf("AVG: %d:%d\n", total/NR/60, (total/NR)%60 ) 
    
}

function HM_to_M( hour, min )
{
    # printf("[%d,%d]\n",hour, min)
    return hour*60 + min    
}

' $*
