#!/bin/bash
# Declare file to store selected menu option
RESPONSE=menu.txt
# Declare file to store content to display output
TEMPORARY=output.txt


function cpu_func(){
	lscpu >$TEMPORARY
	dialog --title "Computer CPU Information" --clear --msgbox "$(<$TEMPORARY)" 75 90
}


function file_sys_func(){
	lsblk >$TEMPORARY
	dialog --title "File System Information" --clear --no-collapse --msgbox "$(<$TEMPORARY)" 24 85
}

function os_func(){
	cat /etc/os-release >$TEMPORARY
	dialog --title "Operating System Type" --clear --msgbox "$(<$TEMPORARY)" 18 90	
}

function memory_func(){
	cat /proc/meminfo >$TEMPORARY
	dialog --title "Memory Information" --clear --msgbox "$(<$TEMPORARY)" 80 40	
}

function disk_func(){
	sudo hdparm -I /dev/sda >$TEMPORARY
	dialog --title "Hard Disk Information" --clear --msgbox "$(<$TEMPORARY)" 80 90	
}


# We are calling infinite loop here
while true
do

# Show main menu
dialog --clear --backtitle "Coursework 2" \
--title "System Functions" \
--nocancel \
--menu "Please use up/down arrow keys, number keys 1,2,3.." 16 70 7 \
OS "Show the Operating System Type" \
CPU "Show the Computer CPU Information" \
Memory "Show the Memory Information" \
Disk "Show the Hard Disk Information" \
System "Show the File System (Mounted) Information" \
Exit "Exit the System functions" 2>"${RESPONSE}"
	
#assigning selection into menuitem
menuitem=$(<"${RESPONSE}")

# Start activity as per selected choice	
case $menuitem in
	OS) os_func;;
    	CPU) cpu_func;;
    	Memory) memory_func;;
    	Disk) disk_func;;
    	System) file_sys_func;;
    	#break is used to exit infinite loop if Exit is selected
    	Exit) exit_func; break;;
esac
done

#assign value of current directory to variable TEMP
TEMP=`pwd` 
#execute main script, courseworkv2.sh when exit option is selected
exec "$TEMP/courseworkv2.sh"

