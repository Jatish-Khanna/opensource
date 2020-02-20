#!/bin/bash

check_file() {
  echo "checking the filepath"

  if [[ -z "$FILENAME" ]]
  then
    echo "Provide file name"
    exit
  fi

}

check_data() {

  if [[ $COUNT -gt 0 ]]
  then
    echo "data found to parse"
  else
    echo "no data present to parse"
  fi
}

print_data() {
  header=(h1,header2)
  echo "printing data"
  #for filename in $(hadoop fs -tail $FILENAME | gawk -F'|' '{print $1 $16}' )
  #do
  #  echo $filename;
  #done
  hadoop fs -tail $FILENAME | gawk -F'|' -v fheader="${header[*]}" '{ OFS=""; split(fheader,list,","); } { printf "{ %s:\"%s\"%s %s:\"%s\" }\n",list[1],$1,",",list[2],$16 }'
}

export FILENAME=$1

check_file
export COUNT=$(hadoop fs -cat $FILENAME | wc -l)
check_data
print_data
