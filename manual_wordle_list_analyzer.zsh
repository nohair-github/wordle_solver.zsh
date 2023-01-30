#!/bin/zsh

# manual_analyze_wordle_list.zsh: script to tabulate letter frequecy generally and 
# in each position and display frequency of letters in those positions selected file

# Developed on macos 16.1 (21.6.0 Darwin Kernel Version 21.6.0: root:xnu-8020.240.7~1/RELEASE_X86_64)
# and zsh (zsh 5.8.1 (x86_64-apple-darwin21.0)

# v0.01 11/24/22 gsb: basic functionality and debugging

print
print "Wordle word list analyzer"
print

# Clear tmp files
if [[ -e letter_list.tmp ]]
  then
  rm letter_list.tmp
  touch letter_list.tmp
fi

# Input list
print -n "Enter name of input file (a list of 5 letter words, one per line):"
read -r FILENAME

# Check if input file exists
if [[ -e $FILENAME ]]
  then
  COUNT=$(wc -l < $FILENAME)
  COUNT=${COUNT// }
  print "$FILENAME contains $COUNT words"
  print -n "Display list? (y/n):"
  read -r RESP0
  if [[ $RESP0 = "y" ]]
    then
    cat $FILENAME
  fi
else
  print "$FILENAME not found. - Exiting"
  exit 1
fi

# Calculate total letter frequency of all words in list $FILENAME
print
print "Combined letter frequency of all words in $FILENAME:"
grep -o . $FILENAME | sort -f | uniq -ic | sort -nr
print

# Find the number of words containing each individual letter
for letter in {a..z}; do
  COUNT=$(grep "$letter" $FILENAME | uniq | wc -l)
  COUNT=${COUNT// }
  if  [[ $COUNT -ge 1 ]]; then
    fletter="${COUNT} $letter"
    echo $fletter >> letter_list.tmp
  fi
done
print "Number of words containing each letter:"
cat letter_list.tmp | sort -rn
print
print "Hint: When choosing letters for next guess, it is more efficient to choose letters"
print "which appear in ~50% of the words."
print

# Find letters in each position of word list

TOTAL=""
for n in {0..4}
do
  POSITION=$(( n+1 ))

  # Tabulate the letters in that position in word list,
  # count the frequency, and display
  POSSIBLE[$POSITION]=$(cut -c $POSITION $FILENAME | sort | uniq -c | sort -nr)
  print "Frequency of letters in position $POSITION in words in $FILENAME:"
  print $POSSIBLE[$POSITION]

  echo $(cut -c $POSITION $FILENAME) >> letter_list.tmp

done

print "Completed"

return 0
