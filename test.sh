# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    test.sh                                            :+:    :+:             #
#                                                      +:+                     #
#    By: dkrecisz <dkrecisz@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2020/07/06 04:44:53 by dkrecisz      #+#    #+#                  #
#    Updated: 2020/09/26 20:20:35 by dkrecisz      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

# COLORS USED FOR PRINTING
CYAN="\033[0;36m"
PURP="\033[0;35m"
GREEN="\033[1;32m"
BLUE="\033[0;34m"
BLUEBG="\033[44m"
WHITE="\033[1;97m"
RESET="\033[0m"

#Regular text
BLK="\e[0;30m"
RED="\e[0;31m"
GRN="\e[0;32m"
YEL="\e[0;33m"
BLU="\e[0;34m"
MAG="\e[0;35m"
CYN="\e[0;36m"
WHT="\e[0;37m"

#Regular bold text
BBLK="\e[1;30m"
BRED="\e[1;31m"
BGRN="\e[1;32m"
BYEL="\e[1;33m"
BBLU="\e[1;34m"
BMAG="\e[1;35m"
BCYN="\e[1;36m"
BWHT="\e[1;37m"

#Regular underline text
UBLK="\e[4;30m"
URED="\e[4;31m"
UGRN="\e[4;32m"
UYEL="\e[4;33m"
UBLU="\e[4;34m"
UMAG="\e[4;35m"
UCYN="\e[4;36m"
UWHT="\e[4;37m"

#Regular background
BLKB="\e[40m"
REDB="\e[41m"
GRNB="\e[42m"
YELB="\e[43m"
BLUB="\e[44m"
MAGB="\e[45m"
CYNB="\e[46m"
WHTB="\e[47m"

#High intensty background 
BLKHB="\e[0;100m"
REDHB="\e[0;101m"
GRNHB="\e[0;102m"
YELHB="\e[0;103m"
BLUHB="\e[0;104m"
MAGHB="\e[0;105m"
CYNHB="\e[0;106m"
WHTHB="\e[0;107m"

#High intensty text
HBLK="\e[0;90m"
HRED="\e[0;91m"
HGRN="\e[0;92m"
HYEL="\e[0;93m"
HBLU="\e[0;94m"
HMAG="\e[0;95m"
HCYN="\e[0;96m"
HWHT="\e[0;97m"

#Bold high intensity text
BHBLK="\e[1;90m"
BHRED="\e[1;91m"
BHGRN="\e[1;92m"
BHYEL="\e[1;93m"
BHBLU="\e[1;94m"
BHMAG="\e[1;95m"
BHCYN="\e[1;96m"
BHWHT="\e[1;97m"

#CLEAR INITIAL TERMINAL WINDOW
clear

#PRINTING STUFF
div1="=========================="
div2="====================="
div3="\t\t"

#WELCOME SCREEN + INSTRUCTIONS
printf "\n\t${BYEL}+====================================+"
printf "\n\t${BYEL}+------------------------------------+"
printf "\n\t${BYEL}+---------${REDB} ${BHWHT}CUB3D DESTROYER ${RESET}${BYEL}----------+"
printf "\n\t${BYEL}+-----${REDB} ${BHWHT}LET'S BREAK YOUR PARSER! ${RESET}${BYEL}-----+"
printf "\n\t${BYEL}+---------${REDB} ${BHWHT}42 Network 2020 ${RESET}${BYEL}----------+"
printf "\n\t${BYEL}+-----------${REDB} ${BHWHT}by dkrecisz ${RESET}${BYEL}------------+"
printf "\n\t${BYEL}+------------------------------------+"
printf "\n\t${BYEL}+====================================+\n${RESET}"
printf "\n${BYEL}+==================${REDB} ${BHWHT}START TESTING ${RESET}${BYEL}==================+\n${RESET}"

#COUNTER FOR PARSER DESTROYED/PASSED CASES
FAIL=0
OK=0

#LOGFILE FOR PARSER DESTROYED STUFF
log=damage_report.log
errorMsg=error.txt
date > $log && printf "\n\n%sCUB3D DESTROYER - DAMAGE REPORT%s\n\n" $div2 $div2 >> $log && echo >> $log

#TEST VALID MAPS
for file in valid_maps/valid_tex_*.cub
do
	../cub3D $file &>$errorMsg &
	sleep 0.05
	killall cub3D &>/dev/null
	grep -q "Error$" $errorMsg
	if [ $? -eq 0 ]
	then
		FAIL=$((FAIL+1))
		printf "${REDB}${BHYEL}MAP: %-42s${RESET}%s${BRED}[DESTROYED]\n" $file " " && printf ${RESET}
		printf "%s[DESTROYED STUFF #%2.d]%s\n" $div1 $FAIL $div1 >> $log && ls $file >> $log && cat $file >> $log && printf "\n\n" >> $log
		printf "PARSER OUTPUT:\n" >> $log && cat $errorMsg >> $log
		cat $file
		echo
	else
		OK=$((OK+1))
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${GREEN}[OK]\n" $file " "
	fi
done

#TEST INVALID MAPS
for file in ./invalid_maps/invalid_*.cub
do
	../cub3D $file &>$errorMsg &
	sleep 0.05
	killall cub3D &>/dev/null
	if [[ $? -eq 0 ]]; then
		FAIL=$((FAIL+1))
		printf "${REDB}${BHYEL}MAP: %-42s${RESET}%s${BRED}[DESTROYED]\n" $file " " && printf ${RESET}
		printf "%s[DESTROYED STUFF #%2.d]%s\n" $div1 $FAIL $div1 >> $log && ls $file >> $log && cat $file >> $log && printf "\n\n" >> $log
		printf "PARSER OUTPUT:\n" >> $log && cat $errorMsg >> $log
		cat $file
		echo
	else
		OK=$((OK+1))
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${GREEN}[OK]\n" $file " "
	fi
done

#OUTPUT FINAL RESULT
printf "\n${WHT}%s${BWHT}FINAL RESULT${WHT}%s\n" $div1 $div1
printf "${BGRN}Bulletproof, nice and smooth:\t%d\t[GREAT JOB MATE]\n" $OK
printf "${BRED}Cases of pure destruction:\t%d \t[RIP IN PIECES]\n" $FAIL
printf "${WHT}%s============%s\n" $div1 $div1
