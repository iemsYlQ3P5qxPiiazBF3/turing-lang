#!/bin/bash
x="$RANDOM"
x="0"
:>"out$x.sh"
echo -e "TAPE=( );HEAD=0;" > "out$x.sh"

for i in $(cat "$1"|tr ';\t ' '\n\nÿ');do
	i=( $(echo $i|tr '.ÿ' '  ') )
	echo "${i[@]}"
	case "${i[0]}" in
		"0")
		echo "_${i[1]}_(){" >> "out$x.sh"
		;;
		"1")
		echo "[ \"\${TAPE[\$HEAD]}\" == \"${i[1]}\" ]&&{" >> "out$x.sh"
		;;
		"2")
		echo "}" >> "out$x.sh"
		;;
		"3")
		echo "((HEAD++));((HEAD>(\${#TAPE[@]}-1)))&&TAPE=( \${TAPE[@]} 0 )" >> "out$x.sh"
		;;
		"4")
		echo "((HEAD--));((HEAD<0))&&{ HEAD=0; TAPE=( 0 \${TAPE[@]} ); }" >> "out$x.sh"
		;;
		"5")
		echo "TAPE[\$HEAD]=\"${i[1]}\"" >> "out$x.sh"
		;;
		"6")
		echo "echo \"Accepted\";exit 0" >> "out$x.sh"
		;;
		"7")
		echo "echo \"Rejected\";exit 1" >> "out$x.sh"
		;;
		"8")
		echo "_${i[1]}_" >> "out$x.sh"
		;;
		"9")
		echo "TAPE=( ${i[@]:1} )" >> "out$x.sh"
		;;
		"A")
		echo "echo \"\${TAPE[@]}\";for i in \$(seq \$HEAD);do echo -n \"  \";done;echo \"^\"" >> "out$x.sh"
		;;
	esac
done
chmod +x "out$x.sh"
ls "out$x.sh"
