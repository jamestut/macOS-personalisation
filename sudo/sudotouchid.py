#!/usr/bin/env python3
import os
import sys
import re

# --- Configuration ---
SUDO_PAM_FILE = "/etc/pam.d/sudo"
# The line we want to add to enable Touch ID
LINE_TO_ADD = "auth sufficient pam_tid.so"
# The line after which we will insert our new line
ANCHOR_LINE_START = "auth include sudo_local"
# A simple way to check if our line already exists
TID_CHECK = "pam_tid.so"

def main():
    """
    Main function to enable Touch ID for sudo.
    """
    # 1. Check for root privileges
    if os.geteuid() != 0:
        print("Error: This script must be run as root.", file=sys.stderr)
        sys.exit(1)

    # 2. Check if the target file exists
    if not os.path.exists(SUDO_PAM_FILE):
        print(f"Error: The required system file '{SUDO_PAM_FILE}' was not found.", file=sys.stderr)
        print("This script is intended for standard macOS installations.", file=sys.stderr)
        sys.exit(1)

    print(f"Reading configuration from {SUDO_PAM_FILE}...")
    try:
        with open(SUDO_PAM_FILE, 'r') as f:
            lines = f.readlines()
    except IOError as e:
        print(f"Error: Could not read the file '{SUDO_PAM_FILE}': {e}", file=sys.stderr)
        sys.exit(1)

    # 3. Check if Touch ID is already configured
    if any(TID_CHECK in line for line in lines):
        print("Touch ID for sudo is already configured.")
        sys.exit(0)

    # 4. Find the anchor line where we'll insert the new configuration
    anchor_line_index = None
    for i, line in enumerate(lines):
        if ' '.join(line.split()) == ANCHOR_LINE_START:
            anchor_line_index = i
            break

    if anchor_line_index is None:
        print(f"Error: The anchor line '{stripped_anchor}' was not found.", file=sys.stderr)
        print("Cannot determine where to add the Touch ID configuration. No changes will be made.", file=sys.stderr)
        sys.exit(1)

    # 5. Insert the new line into the list of lines
    print("Found the anchor line. Proceeding with modification.")
    lines.insert(anchor_line_index + 1, LINE_TO_ADD + "\n")

    # 7. Write the modified content back to the file
    try:
        print(f"Writing updated configuration to {SUDO_PAM_FILE}...")
        with open(SUDO_PAM_FILE, 'w') as f:
            f.writelines(lines)
    except IOError as e:
        print(f"Could not write changes to '{SUDO_PAM_FILE}': {e}", file=sys.stderr)
        print("The file was not modified. Please check permissions and try again.", file=sys.stderr)
        sys.exit(1)

    print("Touch ID for sudo has been enabled.")

if __name__ == "__main__":
    main()
