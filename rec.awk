BEGIN { "date" | getline
        printf("%s %s %s\n", $6,$2,$3);
        printf("ID Number Arrival Time\n") 
        printf("======================\n")
      }
{ printf("%9d %12s\n", $1,$2) | "sort" }  # only execute 1 sort time 
