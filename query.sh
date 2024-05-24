


    if [ ! $? = 0 ] ; then
          # Query package result - no success = 1


        if [[  "$status" =~ ^$cases_query  ]] ; then
            # package status 


            echo "********  TODO:   "        

            pkg_found=0
            query="Not Found"
            echo " \$?: " $?
        else


        fi

            pkg_found=1
            query="Found"
            echo " \$?: " $?

     else 

            echo -e " Warning: "
            echo "***** CHECK ****"
            echo "pkg_found:" $pkg_found
            echo "query:" $query
            echo "status:" $status
            echo "$?: "
            echo "*****************"

                
    fi

#**********************



    if [[ "$OS_DERIVATES"  =~ ^$allowed_packages ]] ; then


        # meet the allowed packages for this app
   
        if [ ! $? = 0 ] ; then
            # Query result - no success = 1
    
            kk=$("$status" =~ ^$cases_query)
            echo "** KK: $kk"

            if [[  "$status" =~ ^$cases_query  ]] ; then
                echo "********  TODO:   "        
                # package status 

                pkg_found=0
                query="Not Found"
                echo " \$?: " $?
            else

                pkg_found=0
                query="Found"
                echo " \$?: " $?

            fi

        else 

            echo -e " Warning: "
            echo "***** CHECK ****"
            echo "pkg_found:" $pkg_found
            echo "query:" $query
            echo "status:" $status
            echo "$?: "
            echo "*****************"

                
        fi
      
    else 
        
        echo -e " - Warning: Packages type not allowed due OS" 
        
    fi
