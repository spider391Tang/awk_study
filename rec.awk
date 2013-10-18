BEGIN { printf("ID Number Arrival Time\n") 
        printf("======================\n")
    }
{printf("%9d %12s\n", $1,$2) }
