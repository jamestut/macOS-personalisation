#!/usr/bin/env python3

import sys
import subprocess
import os

def edit_file(fn):
	theline = "%admin		ALL = (ALL) ALL\n"
	newline = "%admin		ALL = (ALL) NOPASSWD: ALL\n"

	lines = []
	has_change = False
	with open(fn, "r") as f:
		for l in f:
			if not has_change and l == theline:
				has_change = True
				lines.append(newline)
			else:
				lines.append(l)

	if not has_change:
		print("Cannot find the line. Sudoers file not modified.")
	else:
		with open(fn, "w") as f:
			f.writelines(lines)

def run_visudo():
	env = {}
	env.update(os.environ)
	for k in ["EDITOR", "VISUAL"]:
		env[k] = __file__
	subprocess.run(["sudo", "visudo"], env=env, check=True)

def main():
	if not os.access(__file__, os. X_OK):
		print("The script's path must be executable!")
		return 1

	if len(sys.argv) == 1:
		run_visudo()
		print("Done!")
		return 0
	elif len(sys.argv) == 3:
		# in-place edit the file
		if sys.argv[1] == "--":
			try:
				edit_file(sys.argv[2])
				return 0
			except FileNotFoundError:
				print("Please use the path of the sudoers file!")
				return 1

	print("Run this script in sudo to disable sudo password.")
	return 1

if __name__ == "__main__":
	exit(main())
