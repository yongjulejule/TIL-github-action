#!/bin/bash

set -euo pipefail

tmp_file=$(mktemp)
dest_file=${DEST_FILE:-'/dev/null'}

function cleanup {
  echo "cleanup"
  local jobs=$(jobs -p)
  if [ -n "$jobs" ]; then
    kill $jobs
  fi
  rm -f $tmp_file
  exit 1
}

trap cleanup SIGTERM SIGINT

function check_options {
  if [ $# -eq 2 ] && [ "$1" == "-f" ]; then
  	input="Y"
  	if [ ! -f /.dockerenv ] && [ -f "$2" ]; then
  		echo "File named [$2] Aleady exists. Overwrite? (Y/n)"
  		read input
  	fi
  	if [ "$input" == "Y" ]; then
  		echo "Write to file [$2]"
      dest_file=$2
  		exec 1>$tmp_file
  	else
  		echo "Exiting"
  		exit 1
  	fi
  fi
  return 0
}

check_options $@

dirs=($(find $PWD -type d ! -path './.*' | sed 's/^\.\///' | sort))

unset dirs[0]

if [[ -z $dirs ]]; then
  echo "No directories found. Please check again" >&2
  exit 1
fi

cat <<EOF
# TIL

Today I Learned

새로 알게 된 내용들을 저장하는 곳입니다.

EOF

echo "# Index"

 
IFS=$'\n'

for d in ${dirs[@]}; do
	if [[ $d = "image" ]]; then
		continue
	fi
	filepath=$(find $d -maxdepth 1 -type f -name "*.md" ! -name "README.md" | sort)
  if [[ -z $filepath ]]; then
    continue
  fi
  filename=($filepath)
	filename=${filepath[@]//.md/}
  if [[ -z $filename ]]; then
    continue
  fi
	echo -e "\n## $d\n"
	echo -e "|Title|Modified at|"
	echo -e "|:---|:---|"

	for f in $filename; do
		date=$(git log -1 --format=%ci -- $f.md)
		echo "|[${f//*\/}]($f.md)| ${date/ *} |"
	done
done

[ $input == "Y" ] && mv $tmp_file $dest_file

exit 0
