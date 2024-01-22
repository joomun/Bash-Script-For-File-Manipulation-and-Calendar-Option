# BashEventSystemTool

## Overview
SysCalManager is a bash script toolkit designed to manage calendar events and provide essential system information. This project combines two main functionalities: event management (adding, viewing, deleting events) and system information retrieval (CPU, memory, disk, OS details).

## Features
- **Calendar Management**: Users can interact with a calendar interface to add, view, or delete events.
- **System Information**: Retrieve detailed information about the system's CPU, memory, disk, and operating system.
- **User-Friendly Interface**: Utilizes dialog boxes for ease of use and better user experience.

## Getting Started
1. Clone the repository: `git clone [repository-link]`
2. Navigate to the repository directory: `cd SysCalManager`
3. Give execution permission to the scripts: `chmod +x courseworkv2.sh cw2.sh`
4. Run the main script: `./courseworkv2.sh`

## Usage
- Navigate through the menu to access different functionalities.
- Select 'Calendar' to manage events or view the calendar.
- Choose 'System' to view system information.

## Requirements
- Bash shell
- `dialog` package (Install using `sudo apt-get install dialog` on Debian-based systems)

## Custom Dialog Appearance
The project utilizes a customized dialog appearance, enhancing the user interface for better visual experience. Key features include:

- **Color Support**: Full color support for dialog boxes, ensuring a vibrant and engaging user interface.
- **Customizable Elements**: Elements like buttons, borders, and text boxes are configured for optimal visibility and aesthetics.
- **Shadow Effects**: Dialog boxes are designed with shadow effects for a more polished look.

These settings are defined in a separate configuration file, ensuring easy customization and consistent styling across different dialogues.