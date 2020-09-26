# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    destroyer.sh                                       :+:    :+:             #
#                                                      +:+                     #
#    By: dkrecisz <dkrecisz@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2020/07/06 04:44:53 by dkrecisz      #+#    #+#                  #
#    Updated: 2020/09/26 22:13:26 by dkrecisz      ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#Regular bold text
BRED="\e[1;31m"
BGRN="\e[1;32m"
BYEL="\e[1;33m"
BBLU="\e[1;34m"
BWHT="\e[1;37m"

#Regular background
REDB="\e[41m"

#High intensty text
HRED="\e[0;91m"
HYEL="\e[0;93m"
HWHT="\e[0;97m"

#Bold high intensity text
BHYEL="\e[1;93m"
BHWHT="\e[1;97m"

RESET="\033[0m"

#CLEAR INITIAL TERMINAL WINDOW
clear

#PRINTING STUFF lol
div1="=========================="
div2="====================="

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
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${BGRN}[OK]\n" $file " "
	fi
done

#TEST INVALID MAPS
for file in ./invalid_maps/invalid_*.cub
do
	../cub3D $file &>$errorMsg &
	sleep 0.05
	killall cub3D &>/dev/null
	grep -q "Error$" $errorMsg
	if [[ $? -ne 0 ]]; then
		FAIL=$((FAIL+1))
		printf "${REDB}${BHYEL}MAP: %-42s${RESET}%s${BRED}[DESTROYED]\n" $file " " && printf ${RESET}
		printf "%s[DESTROYED STUFF #%2.d]%s\n" $div1 $FAIL $div1 >> $log && ls $file >> $log && cat $file >> $log && printf "\n\n" >> $log
		printf "PARSER OUTPUT:\n" >> $log && cat $errorMsg >> $log
		cat $file
		echo
	else
		OK=$((OK+1))
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${BGRN}[OK]\n" $file " "
	fi
done

rm $errorMsg

#OUTPUT FINAL RESULT
printf "\n\n${BBLU}%s${BWHT}FINAL RESULT${BBLU}%s\n\n" $div1 $div1
printf "${BGRN}PASSED AND BULLETPROOF:\t%d\t[GREAT JOB MATE]\n" $OK
printf "${BRED}FAILED AND DESTROYED:\t%d \t[RIP]\n\n" $FAIL
printf "${BBLU}=========== ${BWHT}FOR MORE INFO: LOOK AT DAMAGE_REPORT.LOG ${BBLU}===========${RESET}\n\n"
