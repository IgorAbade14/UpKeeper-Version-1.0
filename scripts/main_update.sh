#!/bin/bash

# ================================================================= #
# PROJECT: UpKeeper v1.0
# DESCRIPTION: Monthly maintenance automation with GUI.
# OBJECTIVE: Check for weekend status and verify if the current 
#            month's maintenance has already been performed.
# ================================================================= #

# --- 1. CAPTURE AND VARIABLE DEFINITION ---
# %u captures the day (1-7), %m captures the month (01-12)
WEEKDAY=$(date +%u)
CURRENT_MONTH=$(date +%m)
CURRENT_USER=$(whoami)

# Defining the path where the script saves the "state" (memory)
# Using $HOME ensures cross-platform compatibility for the user
STATE_FILE="$HOME/DevOpsLab/UpKeeper/logs/last_run.txt"

# --- 2. ENVIRONMENT PREPARATION (AUTO-HEALING) ---
# Ensures the necessary directory structure exists before execution
mkdir -p "$(dirname "$STATE_FILE")"

# Attempts to read the state file. 
# If file doesn't exist (2>/dev/null), defaults to "00" to allow comparison.
LAST_UPDATE=$(cat "$STATE_FILE" 2>/dev/null || echo "00")

# --- 3. DECISION LOGIC ---
# Condition: If it's Weekend (>= 6) AND current month is different from last update
if [[ $WEEKDAY -ge 6 && $CURRENT_MONTH != $LAST_UPDATE ]]; then

    # Triggers Graphical User Interface (GUI) for user interaction
    if zenity --question \
        --title="UpKeeper v1.0" \
        --text="Hello $CURRENT_USER! I noticed that the monthly maintenance is pending. Do you want to start now?" \
        --ok-label="Yes" \
        --cancel-label="No" \
        --icon-name="system-software-update" \
        --width=350; then

        # --- 4. SYSTEM COMMAND EXECUTION ---
        # Spawns a new terminal instance so the user can monitor apt progress
        gnome-terminal -- bash -c "
            echo 'Starting system update...';
            sudo apt update && sudo apt full-upgrade -y;
            
            # Check if the commands above finished successfully (Exit Code 0)
            if [ \$? -eq 0 ]; then
                # Persists the current month to the state file
                echo $CURRENT_MONTH > $STATE_FILE;
                echo 'Success! The maintenance log has been updated.';
            else
                echo 'Error detected during update. State file was not modified.';
            fi;
            
            echo 'This terminal will close automatically in 5 seconds...';
            sleep 5"
    fi
fi
