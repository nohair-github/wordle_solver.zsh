#!/bin/zsh

# wordle_answer_selector.zsh
# Script to analyze remaining wordle words after a guess and then to help select
# the next guess

# Developed on macos 16.1 (21.6.0 Darwin Kernel Version 21.6.0: root:xnu-8020.240.7~1/RELEASE_X86_64)
# and zsh (zsh 5.8.1 (x86_64-apple-darwin21.0)

# v0.01 11/24/22 gsb: basic functionality and debugging

# 1. Check if input files exist

if [[ -e list.tmp ]]
  then
  print
  print "Wordle answer selector"
  print
  COUNT=$(wc -l < list.tmp)
  COUNT=${COUNT// }
  print "list.tmp contains $COUNT words"
  print -n "Display list? (y/n):"
  read -r RESP0
  if [[ $RESP0 = "y" ]]
    then
    cat list.tmp
  fi
else
  print "list.tmp not found. - Exiting"
  exit 1
fi

if [[ -e wordle_answer.tmp ]]
  then
    ANSWER=$( cat wordle_answer.tmp )
    print
    print "So far, \$ANSWER is $ANSWER"
    print

else
  print "wordle_answer.tmp not found. - Exiting"
  exit 2
fi

#Line 45

# 2. Find which positions $ANSWER lacks identified letter and calculate
# frequency of letters in that position in the remaining possible answers.

for n in {1..5}
do
  POSITION=$(($n-1))
  print
  print "The letter at position $n in \$ANSWER is \"${ANSWER:$POSITION:1}\"."
  if [[ ${ANSWER:$POSITION:1} = "." ]]
  then
    print "No previously guessed letter in position $n."
    # now tabulate the letters in that position in word list,
    # count the frequency, and display
    POSSIBLE[$n]=$(cut -c $n list.tmp | sort | uniq -c | sort -n )
    print "Frequency of letters in position $n in remaining possible answers:"
    print $POSSIBLE[$n]

    # Create an associative array for each position containing a "." with key=letter
    # and value=letter frequency

    # First reverse the order of $POSSIBLE[$n]
    echo "reversed"
    TEMP=$(echo $POSSIBLE[$n] | tr ' ' '\n' | tac | tr '\n' ' ') 
    echo ${(t)TEMP}
    print $TEMP
    print

# Line 73
    
    declare -a TEMP_ARRAY
    #print "Array \$TEMP_ARRAY is of type ${(t)TEMP_ARRAY}"
    #print
    
    TEMP_ARRAY=( `echo $TEMP | grep -o -E ".{1,3} "` )
    #print "TEMP_ARRAY is:"
    #print ${TEMP_ARRAY[@]}
    #print "Number of elements in \$TEMP_ARRAY is ${#TEMP_ARRAY[@]}."
    #print

    #for i in {1..${#TEMP_ARRAY[@]}}
    #do
    #  print "i = $i"
    #  print "\${TEMP_ARRAY[$i]} is ${TEMP_ARRAY[$i]}"
    #  print
    #done

    # Declare the appropriate score array for the current n
    if [[ $n -eq 1 ]]
    then 
     declare -gA SCORE_ARRAY_1
    elif [[ $n -eq 2 ]]
    then 
     declare -gA SCORE_ARRAY_2
    elif [[ $n -eq 3 ]]
    then 
     declare -gA SCORE_ARRAY_3
    elif [[ $n -eq 4 ]]
    then 
     declare -gA SCORE_ARRAY_4
    elif [[ $n -eq 5 ]]
    then 
     declare -gA SCORE_ARRAY_5
    else
     print "Error in \$n - exiting"
     exit 5
    fi

#Line 102

    # loop through the standard array, assigning
    # the values to the associative array as key/value pairs

    for i in {1..${#TEMP_ARRAY[@]}..2}
    do
      print "i = $i"
      print "\${TEMP_ARRAY[$i]} is ${TEMP_ARRAY[$i]}"
      print "\${TEMP_ARRAY[$(($i+1))]} is ${TEMP_ARRAY[$(($i+1))]}"
      print
      ${SCORE_ARRAY_$n[${TEMP_ARRAY[$i]}]}=${TEMP_ARRAY[$(($i+1))]}
    done
#Line 116
    
    # print the associative array to verify the values were assigned correctly
    print "${(P)SCORE_ARRAY_$n}"



    #=$(echo ${TEMP[@]} | sed 's/[^ ]*/[&]=&/g')
    print
    print "or"
    print
    print "${SCORE_ARRAY_$n[@]}"

# create a standard array of values
#array=(value1    value2   value3   value4  value5)

# strip any blank spaces from the values in the array
#array=("${(@)array:#* }")

# join the values in the array with a comma and space
# as a separator and print the resulting string
#echo "${array[*]/(#)/, }"



    # Now, write TEMP_ARRAY into SCORE_ARRAY_$n as "'key' 'value' ...

# create a standard array of values
#array=(value1 value2 value3 value4 value5)

# create an empty associative array
#declare -A assoc_array

# loop through the standard array, assigning
# the values to the associative array as key/value pairs
#for ((i=1; i<=${#array[@]}; i+=2)); do
#  assoc_array[${array[i-1]}]=${array[i]}
#done

# print the associative array to verify the values were assigned correctly
echo "${(P)assoc_array}"



    #typeset -A $SCORE_ARRAY_$n
    #echo ${(t)SCORE_ARRAY_$n}
    #set -A $SCORE_ARRAY_$n "$TEMP[@]"

    #print SCORE_ARRAY_$n[@]

    # Check if assignment worked properly
    #print
    #for k v ("${(@kv)SCORE_ARRAY_$n}") print -r -- "$k => $v"
    print    


    #echo $A | grep t
    #print
    #echo $A | grep t | grep -o -E "[0-9]+"
    #print
    #echo $A | grep t | grep -o -E "[a-z]"
    #print

    # Convert $POSSIBLE[$POSITION] into an associative array
    # by rewriting the results as 'letter' 'frequency'


  else
    print
  fi
done

# 3. Look at list of remaining words (possible answers) and score them using a score
# which in the sum of the frequency of the letter in that position

#Load remaining words into array ANS_ARRAY
typeset -a ANS_ARRAY=($(<list.tmp))

# Use the associative array created above (with key=letter and value=letter frequency
# and iterate through each word in ANS_ARRAY to score it
for m in {1..$COUNT}
do
  print "${ANS_ARRAY[$m]}"
done

print ${POSSIBLE[1]:0:1}
print ${POSSIBLE[1]:0:2}
print ${POSSIBLE[1]:0:3}
print ${POSSIBLE[1]:0:4}
print ${POSSIBLE[1]:0:5}
print ${POSSIBLE[1]:0:6}
print ${POSSIBLE[1]:0:7}
print
echo $POSSIBLE[1] | grep t
print
echo $POSSIBLE[1] | grep t | grep -o -E "[0-9]+"
print
echo $POSSIBLE[1] | grep t | grep -o -E "[a-z]"
 

# 4. Display the possible answers sorted by the highest score based on frequency of letters

# 5. Calculate how many remaining words will be eliminated by the choice of each possible
# word within the list of remaining words

# 6. Display the possible answers sorted by the best to eliminate possible words in the answer list



print "Completed"

exit


