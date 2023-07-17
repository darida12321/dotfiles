#
# Command prompt
#

function fish_prompt
	# Starting free space
	echo ""

	set vi_mode_color blue
	set pwd_color blue
	set git_color cyan

	# Vim mode
	set_color --bold -b normal $vi_mode_color
	echo -n ""

	set_color -o -b $vi_mode_color black
	eval __prompt_section_vi_mode
	echo -n ""

	# Working directory
	set_color -o -b $pwd_color black
	echo -n " "
	eval __prompt_section_pwd
	echo -n " "

	# Git status
	set_color -b $git_color $pwd_color
	echo -n ""

	set_color -o -b $git_color black

	set -l git_section (__prompt_section_git)
	if test -n "$git_section"
		echo -n " $git_section "
	end

	# Final arrow
	set_color -b normal $git_color
	echo -n " "

	set_color -b normal normal
end
