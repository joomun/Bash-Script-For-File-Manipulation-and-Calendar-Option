#!/bin/bash
# Declare file to store selected menu option
RESPONSE=menu.txt

DIALOGRC=/home/joomun/Downloads

# Declare file to store content to display output
TEMPORARY=output.txt


function display_date(){
    echo "            Hello $USER! \n"\
    "Today is `date`." >$TEMPORARY
    dialog --backtitle "Date and time" --title "Date" --clear --msgbox "$(<$TEMPORARY)" 8 45
}



function get_current_directoryDate_func(){
	
	#creating new directory for folder event and adding event text file  
	current_directory=$(pwd)
	result="${current_directory}/events/${dat}.txt"
}


function display_calendar(){

	#date selector
	DATE=$(date "+%d %m %Y")
	dat=$(dialog --stdout --date-format "%Y-%m-%d" \
	--title "Calendar" --nocancel \
	--calendar "Select a date to view, add or delete event :" 0 0 $DATE)
    	
    	#calling function event_selection 
	event_selection
	   
}


function add_func(){

	#checking if event files already exist else creating file for future events
    	mkdir events 
    	current_directory=$(pwd)
    	
    	cd
    	cd "${current_directory}/events"
    	file="${current_directory}/events/${dat}.txt"
    	
    	if test -f "$file"; then
    		break
    	else
  		touch "${dat}".txt
	fi
	
	cd ..
		
	#calling function get_current_directoryDate_func
	get_current_directoryDate_func
	
	#inputting event into variable result
	dialog --title "Date" \
	--backtitle "Date and time" \
	--nocancel \
	--inputbox "Enter event" 8 60 2>$result
}


function View_func(){

	#calling function get_current_directoryDate_func
	get_current_directoryDate_func
	
	#checking if text file already exists
	if [[ -f ${result} ]]
	then
		#display event if file exists
		dialog --backtitle "Date and time" --title "Date" --clear --msgbox "$(<$result)" 8 45
	else
		dialog --backtitle "Date and time" --title "Date" --clear --msgbox "No specific event" 8 45
	fi
}


function Delete_event_func(){
	
	#calling function get_current_directoryDate_func
	get_current_directoryDate_func
	
	dialog --yesno "Are you sure you want to delete this event?" 0 0
		
		#Variable response stores value returned when either yes (0) or no (1) is selected by user
		response=$?
		
		#if yes(0) is selected, it deletes the file else it executes the else statement  
		if [ $response == 0 ] 
		then
			#deleting selected event file
			rm "${current_directory}/events/${dat}.txt"

		else
			dialog --clear --msgbox "Event not deleted" 5 25 
		fi  
	
}


function event_selection(){

	# We are calling infinite loop here
	while true
	do

	# Show main menu
	dialog --clear --backtitle "Events" \
	--title "Menu Slection" \
	--nocancel \
	--menu "Please use up/down arrow keys, number keys 1,2,3.." 16 70 7 \
	View "View event for ${dat}" \
	Add "Add or Amend Event to Calendar on ${dat}" \
	Delete "Delete Event for ${dat}" \
	Exit "Exit the Event functions" 2>"${RESPONSE}"
		
	menuitem=$(<"${RESPONSE}")

	# Start activity as per selected choice	
	case $menuitem in
		Add) add_func;;
	    	View) View_func;;
	    	Delete) Delete_event_func;;
	    	Ammend) Ammend_func;;
	    	#break is used to exit infinite loop if Exit is selected
	    	Exit) break;;
	esac
	done
}



function delete_func(){
	
	function delete_innerfunc(){
		dialog --yesno "Do you really want to delete the file?" 0 0
		
		#Variable response stores value returned when either yes (0) or no (1) is selected by user
		response=$?
		
		#Code inside if statement executes only if user selects yes (0) in dialog box else it goes to else statement
		if [ $response == 0 ] 
		then
			# file selected is assigned to variable file which is declared as local variable  
			local file="$1" 
			
			# deleting selected file 
			/bin/rm $FILE && direc="$file file has been sucessfully deleted."
			dialog --title "Remove File" --clear --msgbox "$direc" 10 50
		else
			dialog --clear --msgbox "File not deleted" 10 20
		fi  
	}
	
	
	result="output.txt"
	
	dialog --title "Directory selection" \
	--backtitle "Deleting file" \
	--nocancel \
	--inputbox "Enter directory" 8 60 2>$result
	# checks if user has written directory and if it is blank, current directory is assigned to variable result 
	if [ $result == "" ]
	then
		`pwd` >$result
	fi
	#assigns selected file to variable FILE
	FILE=$(dialog --title "Delete a file." --stdout --fselect "$(<$result)" 14 48)
	#calls inner function with FILE as parameter  
	[ ! -z $FILE ] && delete_innerfunc "$FILE"
}
		
	
function exit_func(){
	declare -i COUNTER=1
	{
	
	#gauge progress bar value 
    	while test $COUNTER -le 100
        	do
            	echo $COUNTER
            	COUNTER=COUNTER+1
            	sleep 0.019
    	done
    	
    	} |  dialog --gauge  "        Thank you! Now closing application\n  Written by Ashfaaq Hobass and Muddathir Joomun" 10 55 0
    	clear
}


function system_func(){
	#assign value of current directory to variable TEMP
	TEMP=`pwd` 
	
	#execute file cw2.sh
	exec "$TEMP/cw2.sh"
	
}	

	
# We are calling infinite loop here
while true
do

# Show main menu
dialog --clear --backtitle "Coursework 2" \
--title "[ MENU ]" \
--nocancel \
--menu "     Please use up/down arrow keys, number keys 1,2,3..\n"\
"        or the first character of choice as hot key\n"\
"            or cursor to select an option" 16 70 7 \
Calendar "Show the Calendar" \
System "Show the system information" \
Date/time "Show date and time" \
Delete "Delete selected file" \
Exit "Terminate the Script" 2>"${RESPONSE}"


#assigning selected value 
menuitem=$(<"${RESPONSE}")


# Start activity as per selected choice
case $menuitem in
    Calendar) display_calendar;;
    Date/time) display_date;;
    System) system_func;;
    Delete) delete_func;;
    #break is used to exit infinite loop if Exit is selected 
    Exit) exit_func; break;;
esac
done

# Delete temporary files
[ -f $TEMPORARY ] && rm $TEMPORARY
[ -f $RESPONSE ] && rm $RESPONSE


