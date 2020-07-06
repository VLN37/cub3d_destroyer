# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    start_test.sh                                      :+:    :+:             #
#                                                      +:+                     #
#    By: dkrecisz <dkrecisz@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2020/07/06 04:44:53 by dkrecisz      #+#    #+#                  #
#    Updated: 2020/07/06 06:51:09 by dkrecisz      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# COLORS USED FOR PRINTING
CYAN="\033[0;36m"
PURP="\033[0;35m"
GREEN="\033[1;32m"
BLUE="\033[0;34m"
BLUEBG="\033[44m"
WHITE="\033[1;97m"
RESET="\033[0m"
#MAP NUMBER
MAP_NUM=1
#CLEAR INITIAL TERMINAL WINDOW
clear

#WELCOME SCREEN + INSTRUCTIONS
printf "\n${BLUEBG}${WHITE} ++++++CUB3D DESTROYER++++++ ${RESET}\n"
printf "${BLUEBG}${WHITE}+++LET'S BREAK YOUR PARSER+++${RESET}\n"
printf "${WHITE}        by dkrecisz${RESET}\n\n"
printf "${BLUEBG}${WHITE}1.${RESET}${GREEN} Compile your \"cub3D\" executable in parent directory!${RESET}\n"
printf "${BLUEBG}${WHITE}2.${RESET}${GREEN} Hit ${WHITE}ENTER TO START${GREEN} the test!${RESET}\n"
printf "${BLUEBG}${WHITE}3.${RESET}${GREEN} Hit ${WHITE}\"q\" TO QUIT${GREEN} the script anytime!${RESET}\n"
printf "${BLUEBG}${WHITE}4.${RESET}${GREEN} Eventually compile your program without the raycasting functions \n\
   for a more comfortable testing process.${RESET}\n\n"

#ITERATE THROUGH ALL MAPS
for file in ./maps/*.cub
do
    printf "\n${WHITE}[ENTER] TO CONTINUE TEST!${RESET}\n"
    printf "${WHITE}  [q]   TO QUIT!${RESET}\n"
    read -s -n 1 KEY
    if [$KEY == ""]; then
        clear
        ls $file
        cat $file
        echo
        ../cub3D $file
    elif [ $KEY == 'q' ]; then
        clear
        break
    fi
done
