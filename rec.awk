awk '
BEGIN { "date" | getline
        printf("%s %s %s\n", $6,$2,$3);
        printf("ID Number Arrival Time\n") 
        printf("======================\n")

        lateFile = $2 "late.dat"
        while( getline < lateFile > 0 ) cnt[$1] = $2
        close( lateFile )
}

{ 
    arrival = HM_to_M( substr( $2, 1, length($2) - 3 ), 
            substr( $2, length($2) - 1 ) )

    if( arrival > 480 )
    {
        mark = "*"
        cnt[$1]++
    }
    else
    {
        mark = ""
    }

    message = cnt[$1] ? cnt[$1] " times" : ""
    total += arrival
    printf("%9d %12s %2s %s\n", $1,$2, mark, message ) | "sort"   # only execute 1 sort time 
}

END {
    close("sort")  # close pipe to force flush
    printf("AVG: %d:%d\n", total/NR/60, (total/NR)%60 ) 

    for( ant in cnt )
    {
        printf("%d %d\n") > late_file    
    }
    
}

function HM_to_M( hour, min )
{
    # printf("[%d,%d]\n",hour, min)
    return hour*60 + min    
}

' $*
