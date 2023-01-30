#!/bin/zsh

# manual_update_of_unused_wordle_answers.txt.zsh
# Updates file unused_wordle_answers.txt by removing current answer from list

print -n "Enter NEW_ANSWER:"
read -r NEW_ANSWER
print "\$NEW_ANSWER is $NEW_ANSWER"

# Add answer to past_wordle_answers.txt
lines=$(wc -l < past_wordle_answers.txt)
print "past_wordle_answers.txt contains $lines answers"
print "Adding $NEW_ANSWER to past_wordle_answers.txt"
echo $NEW_ANSWER >> past_wordle_answers.txt

# Sort past_wordle_answers.txt alphabetically
sort past_wordle_answers.txt > past_wordle_answers.tmp
cp past_wordle_answers.tmp past_wordle_answers.txt

# Back up list of past wordle answers
lines=$(wc -l < past_wordle_answers.txt)
print "past_wordle_answers.txt now contains $lines answers"

# Remove corrected_unused_wordle_answers.txt if exists
if [ -e corrected_unused_wordle_answers.txt ]
then
  print "corrected_unused_wordle_answers.text exists ... deleting"
  rm corrected_unused_wordle_answers.txt
  print "Done"
fi
touch corrected_unused_wordle_answers.txt

lines=$(wc -l < unused_wordle_answers.txt)
print "unused_wordle_answers.txt contains $lines lines"

print "Deleting $NEW_ANSWER from unused_wordle_answers.txt"

grep -v "$NEW_ANSWER" unused_wordle_answers.txt > corrected_unused_wordle_answers.txt

# Check for grep errors
  if [[ $? -ge "2" ]]
  then  
    print -n "Error in grep - Exiting."
    exit 1
  fi

lines=$(wc -l < corrected_unused_wordle_answers.txt)

print "corrected_unused_wordle_answers.txt now contains $lines lines"

# Update unused_wordle_answers.txt
print "Updating unused_wordle_answers.txt ..."

cat corrected_unused_wordle_answers.txt > unused_wordle_answers.txt

lines=$(wc -l < unused_wordle_answers.txt)
print "unused_wordle_answers.txt now contains $lines lines"

# Back up past_wordle_answers.txt and new unused_wordle_answers.txt
#print "Back up past_wordle_answers.txt and new unused_wordle_answers.txt? (Y/n)"


print "... Done."

return
