#
# Pwd
#

function __prompt_section_pwd -d "Display the current working directory"
	echo -n (prompt_pwd --full-length-dirs=2 --dir-length=1)
end
