#!/bin/bash
x="$RANDOM"
x="0"
:>"out$x.sh"
echo -e "TAPE=( );HEAD=0;" > "out$x.sh"

for i in $(cat "$1"|tr ';\t ' '\n\nÿ');do
	i=( $(echo $i|tr ',ÿ' '  ') )
	echo "${i[@]}"
	case "${i[0]}" in
		"B")
		echo -e "${i[1]}(){\nSTATE=\"${i[1]}\"" >> "out$x.sh"
		;;
		"Q")
		echo "[ \"\${TAPE[\$HEAD]}\" == \"${i[1]}\" ]&&{" >> "out$x.sh"
		;;
		".B"|".Q")
		echo "}" >> "out$x.sh"
		;;
		"R")
		echo "((HEAD++));((HEAD>(\${#TAPE[@]}-1)))&&TAPE=( \${TAPE[@]} 0 )" >> "out$x.sh"
		;;
		"L")
		echo "((HEAD--));((HEAD<0))&&{ HEAD=0; TAPE=( 0 \${TAPE[@]} ); }" >> "out$x.sh"
		;;
		"W")
		echo "TAPE[\$HEAD]=\"${i[1]}\"" >> "out$x.sh"
		;;
		"_A")
		echo "echo \"Accepted\";exit 0" >> "out$x.sh"
		;;
		"_R")
		echo "echo \"Rejected\";exit 1" >> "out$x.sh"
		;;
		"S")
		echo "${i[1]}" >> "out$x.sh"
		;;
		"T")
		echo "TAPE=( ${i[@]:1} )" >> "out$x.sh"
		;;
		"#")
		echo "# ${i[@]:1}" >> "out$x.sh"
		;;
		"P")
		echo "echo \"\${TAPE[@]}; S: \$STATE\";for i in \$(seq \$HEAD);do echo -n \"  \";done;echo \"^\"" >> "out$x.sh"
		;;
	esac
done
chmod +x "out$x.sh"
ls "out$x.sh"