Wordle solver script by gsb

Developed on macos 12.6.2 (21.6.0 Darwin Kernel Version 21.6.0: root:xnu-8020.240.7~1/RELEASE_X86_64) and zsh (zsh 5.8.1 (x86_64-apple-darwin21.0)

Use:
cd into wordle directory
enter "zsh wordle_solver" and follow prompts

Version history:

Version 0.01 (11/20/22):
Getting script to function, including lots of diagnostic and debug messages.

Version 0.02 (11/23/22):
Less debug and extraneous messages
more informative messaging
corrected formatting
correcting and improving logic
correcting regexs
changing variable names to all caps.

Version 0.03 (11/24/22):
Added basic analysis subroutine
added more error trapping
edited messages to be more informative
somewhat less debug and extraneous messages
improving logic.

Version 0.031: last unitary script.

Version 0.04 (12/23/22):
Split matching steps into subprograms
re-ordered matching logic and sequence
added logic to better deal with duplicate letters in guesses and answers
initial input loop changes to allow typos
incorporation of Wordle's allowed guesses list

Version 0.1 (1/14/23): Added since v0.04:
list-$i.txt copied to $ANSWER if one solution left,
link changed to update_unused_wordle_answers.txt.zsh,
corrected references to list_$i.txt and list.tmp so they are updated when exiting subroutine,
addition of verbosity switches in some locations,
checking validity of response and trap errors,
change y/n input loops where appropriate to handle invalid answers without exiting,
better analysis after each guess to include total letter frequency not just by position (analyzer subroutine),
incorporation of list of unused answers reducing universe of possibles (analyzer subroutine),
bug fixes, improved handling of words with duplicate letters,
added option flags for -v --verbose, and -q --quiet,
improved logic and algoritm to eliminate unmatched letters.

Version 0.2 (2/27/23): Added since v0.1 -
began supporting --debug flag and altering --verbose switches, fixed handling of null input in part 2 script,
fixed handling of duplicate letters in part2, changed part 3 script to automatically select unmatched letters,
continued standardization of [ ]'s to [[ ]]'s and variable quoting inside brackets, changed wordle_list_analyzer
to display data based on unused answer list, fixed input loop on part2 to handle invalid answers,
link changed to update_unused_wordle_answers.v0.2, further bug fixes
