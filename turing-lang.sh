#!/bin/bash
x="$RANDOM"
x="0"
:>"out$x.sh"
echo -e "TAPE=( );HEAD=0;" > "out$x.sh"

for i in $(cat "$1"|tr ';\t ' '\n\n');do
	i=( $(echo $i|tr ',' ' ') )
	echo "${i[@]}"
	case "${i[0]}" in
		"B")
		echo "${i[1]}(){" >> "out$x.sh"
		;;
		"Q")
		echo "$(base64 -d<<<'WyAiJHtUQVBFWyRIRUFEXX0iID09ICI=')${i[1]}$(base64 -d<<<'IiBdJiZ7')" >> "out$x.sh"
		;;
		".B"|".Q")
		echo "}" >> "out$x.sh"
		;;
		"R")
		echo "((HEAD++));((HEAD>\${#TAPE[@]}))&&TAPE=( \${TAPE[@]} 0 )" >> "out$x.sh"
		;;
		"L")
		echo "((HEAD--));((HEAD<0))&&{ HEAD=0; TAPE=( 0 \${TAPE[@]} ); }" >> "out$x.sh"
		;;
		"W")
		v="$(echo ${i[1]}|head -c1)"
		echo "TAPE[\$HEAD]=\"$v\"" >> "out$x.sh"
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
		v="$(echo ${i[1]}|sed 's/.\{1\}/& /g')"
		echo "TAPE=( $v )" >> "out$x.sh"
		;;
		"#")
		echo "# ${i[1]}" >> "out$x.sh"
		;;
		"P")
		echo "echo \"\${TAPE[@]}\";for i in \$(seq \$HEAD);do echo -n \"  \";done;echo \"^\"" >> "out$x.sh"
	esac
done
chmod +x "out$x.sh"
ls "out$x.sh"
