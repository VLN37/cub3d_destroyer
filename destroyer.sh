# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    destroyer.sh                                       :+:    :+:             #
#                                                      +:+                     #
#    By: dkrecisz <dkrecisz@student.codam.nl>         +#+                      #
#                                                    +#+                       #
#    Created: 2020/07/06 06:44:53 by dkrecisz      #+#    #+#                  #
#    Updated: 2020/11/05 14:04:27 by dkrecisz      ########   odam.nl          #
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
YELB="\e[43m"

#High intensty text
HRED="\e[0;91m"
HYEL="\e[0;93m"
HWHT="\e[0;97m"

#High intensty background 
YELHB="\e[0;103m"

#Bold high intensity text
BHYEL="\e[1;93m"
BHWHT="\e[1;97m"

RESET="\033[0m"

#CLEAR INITIAL TERMINAL WINDOW
clear

#PRINTING STUFF lol
div1="=================================================="
div2="--------------------------------------------------"


#WELCOME SCREEN + INSTRUCTIONS

printf "\n\t${BYEL}+%.36s+" $div1
printf "\n\t${BYEL}+%.36s+" $div2
printf "\n\t${BYEL}+---------${REDB} ${BHWHT}CUB3D DESTROYER ${RESET}${BYEL}----------+"
printf "\n\t${BYEL}+-----${REDB} ${BHWHT}LET'S BREAK YOUR PARSER! ${RESET}${BYEL}-----+"
printf "\n\t${BYEL}+---------${REDB} ${BHWHT}42 Network 2020 ${RESET}${BYEL}----------+"
printf "\n\t${BYEL}+-----------${REDB} ${BHWHT}by dkrecisz ${RESET}${BYEL}------------+"
printf "\n\t${BYEL}+%.36s+" $div2
printf "\n\t${BYEL}+%.36s+\n${RESET}" $div1


#Try to make cub3D

printf "\n${BHWHT}Attempting to make cub3D in parent directory...\n"
echo "$ make -C ../ &>/dev/null" && make -C ../ &>/dev/null

if [[ $? -ne 0 ]]; then
	printf "\n${BYEL}${REDB}${BHWHT}Error: Failed to make cub3D in parent directory!${BYEL}\n${RESET}"
	exit 1
else
	ls .. | grep -q "cub3D$"
	if [[ $? -ne 0 ]]; then
		printf "\n${BYEL}${REDB}${BHWHT}Error: Name of executable is wrong! [Correct naming \"cub3D\"]${BYEL}\n${RESET}"
		exit 1
	else
		printf "\n${BGRN}Cub3D successfully made!\n${RESET}"
	fi
fi


#COUNTER FOR PARSER DESTROYED/PASSED CASES
FAIL=0
OK=0

#LOGFILE FOR PARSER DESTROYED STUFF
log=damage_report.log
out=tmp.txt
date > $log && printf "\n\n%.15s CUB3D DESTROYER - DAMAGE REPORT %.15s\n\n" $div1 $div1 >> $log


# #ITERATE THROUGH INVALID MAPS
printf "\n${BYEL}+%.19s${REDB} ${BHWHT}TEST INVALID MAPS ${RESET}${BYEL}%.19s+\n${RESET}" $div1 $div1
for file in ./invalid_maps/*.cub
do
	../cub3D $file &>$out &
	sleep 0.5
	kill $! &>/dev/null
	wait $! &>/dev/null
	RET=$?
	grep -q "Error$" $out
	if [[ $? -ne 0 || $RET -eq 139 ]]; then
		FAIL=$((FAIL+1))
		#TERMINAL OUTPUT
		printf "${REDB}${BHYEL}MAP: %-42s${RESET}%s${BRED}[DESTROYED]\n${RESET}" $file
		printf "${REDB}${BWHT}%.21s${REDB}${BHYEL} FILE CONTENTS ${REDB}${BWHT}%.21s${RESET}\n" $div1 $div1
		cat $file
		printf "\n${BYEL}%.21s${REDB}${BHYEL} PARSER OUTPUT ${RESET}${BYEL}%.21s${RESET}\n" $div1 $div1
		cat $out
		if [ $RET -eq 139 ]; then
			echo "[139] Segmentation fault"
			echo "[139] Segmentation fault" >> $log
		fi
		#LOGFILE OUTPUT
		printf "\n\n%.21s[DESTROYED STUFF #%2.d]%.21s\n" $div1 $FAIL $div1 >> $log && ls $file >> $log && cat $file >> $log
		printf "\n\nPARSER OUTPUT:\n" >> $log
		cat $out >> $log
		printf "${REDB}${BWHT}%.21s${YELHB}${BRED} CONTINUE TEST ${REDB}${BWHT}%.21s${RESET}\n" $div1 $div1
		echo
	else
		OK=$((OK+1))
		ARG_TEST_MAP=$file
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${BGRN}[OK]\n" $file
	fi
	rm -f $out
done

# #ITERATE THROUGH VALID MAPS
printf "\n${BYEL}+%.20s${REDB} ${BHWHT}TEST VALID MAPS ${RESET}${BYEL}%.20s+\n${RESET}" $div1 $div1
for file in valid_maps/*.cub
do
	../cub3D $file &>$out &
	sleep 0.3
	kill $! &>/dev/null
	wait $! &>/dev/null
	RET=$?
	grep -q "Error$" $out
	if [[ $? -eq 0 || $RET -eq 139 ]]; then
		FAIL=$((FAIL+1))
		#TERMINAL OUTPUT
		printf "${REDB}${BHYEL}MAP: %-42s${RESET}%s${BRED}[DESTROYED]\n${RESET}" $file
		printf "${REDB}${BWHT}%.21s${REDB}${BHYEL} FILE CONTENTS ${REDB}${BWHT}%.21s${RESET}\n" $div1 $div1
		cat $file
		printf "\n${BYEL}%.21s${REDB}${BHYEL} PARSER OUTPUT ${RESET}${BYEL}%.21s${RESET}\n" $div1 $div1
		cat $out
		if [[ $RET -eq 139 ]]; then
			echo "[139] Segmentation fault"
			echo "[139] Segmentation fault" >> $log
		fi
		#LOGFILE OUTPUT
		printf "\n\n%.21s[DESTROYED STUFF #%2.d]%.21s\n" $div1 $FAIL $div1 >> $log && ls $file >> $log && cat $file >> $log
		printf "\n\nPARSER OUTPUT:\n" >> $log
		cat $out >> $log
		printf "${REDB}${BWHT}%.21s${YELHB}${BRED} CONTINUE TEST ${REDB}${BWHT}%.21s${RESET}\n" $div1 $div1
		echo
	else
		OK=$((OK+1))
		ARG_TEST_MAP=$file
		printf "${REDB}${BHYEL}MAP:${RESET}${BWHT} %-42s${RESET}%s${BGRN}[OK]\n" $file
	fi
	rm -f $out
done


#TEST "--save"
if [ $OK -gt 0 ]; then
	printf "\n${BYEL}+%.18s${REDB} ${BHWHT}TEST \"--SAVE\" ARGUMENT ${RESET}${BYEL}%.18s+\n${RESET}" $div1 $div1
	INPUT="argument_list.txt"
	while IFS= read -r line
	do
		../cub3D valid_maps/valid_res_000.cub "$line" &>$out &
		sleep 0.3
		kill $! &>/dev/null
		wait $! &>/dev/null
		RET=$?
		grep -q "Error$" $out
		if [[ $? -ne 0 ]]; then
			FAIL=$((FAIL+1))
			#TERMINAL OUTPUT
			printf "${REDB}${BHYEL}CMD:${RESET}${BHYEL} %-53s${BRED}[DESTROYED]\n${RESET}" "../cub3D $ARG_TEST_MAP \"$line\""
			printf "${BYEL}%.21s${REDB}${BHYEL} PARSER OUTPUT ${RESET}${BYEL}%.21s${RESET}\n" $div1 $div1
			cat $out
			if [[ $RET -eq 139 ]]; then
				echo "[139] Segmentation fault"
				echo "[139] Segmentation fault" >> $log
			fi
			# #LOGFILE OUTPUT
			printf "\n\n%.21s[DESTROYED STUFF #%2.d]%.21s\n" $div1 $FAIL $div1 >> $log
			printf "\n../cub3D $ARG_TEST_MAP \"$line\"" >> $log
			printf "\n\nPARSER OUTPUT:\n" >> $log
			cat $out >> $log
			echo
		else
			OK=$((OK+1))
			printf "${REDB}${BHYEL}CMD:${RESET} ${BWHT}%-53s${BWHT}${BGRN}[OK]\n" "../cub3D $ARG_TEST_MAP \"$line\""
		fi
		rm -f $out
	done < "$INPUT"
fi


#OUTPUT FINAL RESULT
printf "\n\n${BBLU}%.21s${BWHT} FINAL RESULT ${BBLU}%.21s\n\n" $div1 $div1
printf "${BGRN}BULLETPROOF:\t%d\t\n" $OK
printf "${BRED}DESTROYED:\t%d \t\n\n" $FAIL
if [ $FAIL -eq 0 ]; then
	rm -f $log
	printf "${BBLU}%.16s ${BWHT} PARSER IS BULLETPROOF ${BBLU} %.16s${RESET}\n\n" $div1 $div1
else
	printf "${BBLU}%.14s ${BWHT} DAMAGE_REPORT.LOG CREATED ${BBLU} %.14s${RESET}\n\n" $div1 $div1
fi

exit 0
