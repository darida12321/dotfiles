#
# Git
#

function __prompt_section_git -d "Display the git branch and status"
	set -l git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if test -n "$git_branch"
		echo -n "$git_branch"
	end

	set -l git_status (__prompt_section_git_status)
	if test -n "$git_status"
		echo -n "[$git_status]"
	end
end

#
# Git status
#
function __prompt_section_git_status -d "Display the current git status"
	# ---------------------------------------------------------------------------
	# Configuration
	# ---------------------------------------------------------------------------

	set SPACEFISH_GIT_STATUS_UNTRACKED \?
	set SPACEFISH_GIT_STATUS_ADDED +
	set SPACEFISH_GIT_STATUS_MODIFIED !
	set SPACEFISH_GIT_STATUS_RENAMED »
	set SPACEFISH_GIT_STATUS_DELETED ✘
	set SPACEFISH_GIT_STATUS_STASHED \$
	set SPACEFISH_GIT_STATUS_UNMERGED =
	set SPACEFISH_GIT_STATUS_AHEAD ⇡
	set SPACEFISH_GIT_STATUS_BEHIND ⇣
	set SPACEFISH_GIT_STATUS_DIVERGED ⇕
	set SPACEFISH_GIT_PROMPT_ORDER untracked added modified renamed deleted stashed unmerged diverged ahead behind

	# ---------------------------------------------------------------------------
	# Section
	# ---------------------------------------------------------------------------

	set -l git_status
	set -l is_ahead
	set -l is_behind

	set -l index (command git status --porcelain 2>/dev/null -b)
	set -l trimmed_index (string split \n $index | string sub --start 1 --length 2)

	for i in $trimmed_index
		if test (string match '\?\?' $i)
			set git_status untracked $git_status
		end
		if test (string match '*A*' $i)
			set git_status added $git_status
		end
		if test (string match '*M*' $i)
			set git_status modified $git_status
		end
		if test (string match '*R*' $i)
			set git_status renamed $git_status
		end
		if test (string match '*D*' $i)
			set git_status deleted $git_status
		end
		if test (string match '*U*' $i)
			set git_status unmerged $git_status
		end
	end

	# Check for stashes
	if test -n (echo (command git rev-parse --verify refs/stash 2>/dev/null))
		set git_status stashed $git_status
	end

	# Check whether the branch is ahead
	if test (string match '*ahead*' $index)
		set is_ahead true
	end

	# Check whether the branch is behind
	if test (string match '*behind*' $index)
		set is_behind true
	end

	# Check whether the branch has diverged
	if test "$is_ahead" = "true" -a "$is_behind" = "true"
		set git_status diverged $git_status
	else if test "$is_ahead" = "true"
		set git_status ahead $git_status
	else if test "$is_behind" = "true"
		set git_status behind $git_status
	end

	set -l full_git_status
	for i in $SPACEFISH_GIT_PROMPT_ORDER
		set i (string upper $i)
		set git_status (string upper $git_status)
		if contains $i in $git_status
			set -l status_symbol SPACEFISH_GIT_STATUS_$i
			set full_git_status "$$status_symbol$full_git_status"
		end
	end

	# Check if git status
	echo -n $full_git_status
end
