#!/bin/bash

# Environment control



# Load environment variables from the specified file
if [[ -f "$ENVIRONMENT" ]]; then
    source ""$ENVIRONMENT""
else
    show_message_with_prefix "Environment file not found "
fi



function capture_env_values() {	
  
  ok " Environment Snapshot"

  # Capture initial values
  initial_install_googlechrome=$install_googlechrome
  initial_APPDIR=$APPDIR
  initial_helpers=$helpers
  initial_allowed_packages=$allowed_packages
  initial_ENVIRONMENT=$ENVIRONMENT
  initial_OS=$OS
  initial_VER=$VER
  initial_PACKAGE_MGR=$PACKAGE_MGR
  initial_PACKAGE_EXT=$PACKAGE_EXT
  initial_prompt_enable=$prompt_enable
}


# Function to check for changes in variables
function check_env_changes {

    show_message "Checking environment"

    if [[ "$install_googlechrome" != "$initial_install_googlechrome" ]] ||
       [[ "$APPDIR" != "$initial_APPDIR" ]] ||
       [[ "$helpers" != "$initial_helpers" ]] ||
       [[ "$ENVIRONMENT" != "$initial_ENVIRONMENT" ]] ||
       [[ "$allowed_packages" != "$initial_allowed_packages" ]] ||
       [[ "$OS" != "$initial_OS" ]] ||
       [[ "$VER" != "$initial_VER" ]] ||
       [[ "$PACKAGE_MGR" != "$initial_PACKAGE_MGR" ]] ||
       [[ "$PACKAGE_EXT" != "$initial_PACKAGE_EXT" ]] ||
       [[ "$prompt_enable" != "$initial_prompt_enable" ]]; then


	 # Call function to update the environment variables file
     update_environment_file

	# Call the OS and package check script
    #source $HELPERS/012-os-packages_management_helper.sh  
	# Ensure this script is in the same directory or provide the full path

    # Update initial values after detecting a change
	capture_env_values


    fi
}


# Function to update the environment variables file based on current values
function update_environment_file {
    show_message "Updating environment file with new values..."

    # Write the current environment variables to the existing file with comments above them and spacing between variables
    cat <<EOF > "$ENVIRONMENT"


#  Default Directory if was downloaded by using:  git clone <.../consoleX.git>
APPDIR="$HOME/consoleX"

# allowed packages
allowed_packages="(deb|rpm)"

#  Components directory
helpers="$APPDIR/helpers"

# Indicates whether Google Chrome is installed (true/false)
install_googlechrome="$install_googlechrome"

# The operating system being used
OS="$OS"

# The version of the operating system
VER="$VER"

# The package manager being used for installations
PACKAGE_MGR="$PACKAGE_MGR"

# The package format used for installations (e.g., rpm, deb)
PACKAGE_EXT="$PACKAGE_EXT"

# Indicates whether the Bash prompt by Powerline is enabled (true/false)
prompt_enable="$prompt_enable"
EOF

	ok  "Environment updated at $ENVIRONMENT"
}


# Function to create a new environment file based on current variables
function create_new_env_file {
    NEW_ENV_FILE="$APPDIR/console.env"
    
    # Write the current environment variables to the new file with comments above them and spacing between variables
    cat <<EOF > "$NEW_ENV_FILE"

#  Default Directory if was downloaded by using:  git clone <.../consoleX.git>
APPDIR="$HOME/consoleX"


# allowed packages 
allowed_packages="(deb|rpm)"

#  Components directory
helpers="$APPDIR/helpers"

# Indicates whether Google Chrome is installed (true/false)
install_googlechrome="$install_googlechrome"

# The operating system being used
OS="rocky"

# The version of the operating system
VER="9.0"

# The package manager being used for installations
PACKAGE_MGR=""

# The package format used for installations (e.g., rpm, deb)
PACKAGE_EXT=""

# Indicates whether the Bash prompt by Powerline is enabled (true/false)
prompt_enable="true"
EOF

	show_message_with_prefix " New environment file created at $NEW_ENV_FILE"    

}

# Call the check_changes function whenever needed
check_env_changes  # Call this function whenever you want to check for changes

# Create a new environment file based on current variables
create_new_env_file  # Create the new file environment (if needed)



