#!/bin/bash

ADVISOR="$0"
ARGUMENTS=("$@")
ARGUMENTS_NUMBER="$#"
RESULT=""

die() {
	echo "$*" >&2
	exit 444
}

help() {
	echo "völva is a seer. she says you what should do."
	echo "you can use the program as the following example."
	echo "~$ ./völva.sh option1 percentage1 option2 percentage2"
	echo ""
	echo "example:"
	echo "~$ ./völva.sh cinema 30 hangOut 20 coding 50"
	exit 0
}

show_the_result() {
	options=""

	counter=0
	for argument in "${ARGUMENTS[@]}"; do
		if [[ $(( counter%2 )) -eq "0" ]]; then
			options+="\"$argument\" "
		fi
		counter=$(( counter+1 ))
	done

	echo "hello there! i am völva the seer."
	echo "i will choose the best option for you between ${options}."
	for counter in $(seq 1 10); do
		sleep .5
		echo -en "."
	done
	echo ""
	echo ""

	echo "..tadaaa.."
	sleep .8
	echo "you should do \"$RESULT\"."
}

tell_me_what_to_do() {
	random=$(( ( RANDOM % 100 )  + 1 ))

	counter=0
	previous_ones=0
	for argument in "${ARGUMENTS[@]}"; do
		if [[ $(( counter%2 )) -eq "1" ]]; then
			if [[ "$random" -ge "$previous_ones" && "$random" -le $(( previous_ones+argument )) ]]; then
				RESULT=${ARGUMENTS[$(( counter-1 ))]}
			fi
			previous_ones=$(( previous_ones+argument ))
		fi
		counter=$(( counter+1 ))
	done
}

check_percentages() {
	counter=0
	percentage=0
	
	for argument in "${ARGUMENTS[@]}"; do
		if [[ $(( counter%2 )) -eq "1" ]]; then
			percentage=$(( percentage+argument ))
		fi
		counter=$(( counter+1 ))
	done

	if [[ "$percentage" -eq "100" ]]; then
		main
	else
		die "percentage totals are not 100."
	fi
}

check_args() {
	if [[ "$ARGUMENTS_NUMBER" -eq "1" && "${ARGUMENTS[0]}" == "--help" ]]; then
		help
	elif [[ $(( ARGUMENTS_NUMBER%2 )) -eq "0" ]]; then
		if [[ "$ARGUMENTS_NUMBER" -lt "4" ]]; then
			echo "$0 needs 2 couple arguments at least."
		elif [[ "$ARGUMENTS_NUMBER" -gt "20"  ]]; then
			echo "$0 needs 10 couple arguments at most."
		else
			check_percentages
		fi
	else
		echo "$0 needs couple arguments. $ARGUMENTS_NUMBER is not a even number."
	fi
}

main() {
	tell_me_what_to_do
	show_the_result
}

clear
check_args
