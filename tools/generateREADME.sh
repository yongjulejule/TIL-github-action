#!/bin/bash

set -x

set -- "$@" "-f" "README.md"

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

echo "Write to file [$2]"
dest_file=$2
exec 1>$tmp_file

dirs=($(find . -type d ! -path './.*' | sed 's/^\.\///' | sort))

unset dirs[0]

if [[ -z $dirs[@] ]]; then
  echo "No directories found. Please check again" >&2
  exit 1
fi

cat <<EOF
# TIL

${TIL_HEADER}

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

mv $tmp_file $dest_file

exit 0
