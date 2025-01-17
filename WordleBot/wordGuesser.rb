# File: wordGuesser.rb
# Author: Arvid Möller
# Date: 2025-01-17
# Description: This program guesses a word to enter in Wordle.
# Required files: void
# Required gems: void


# Guesses a word based on data-state of previous letters and what row it is (words with duplicate letters aren't allowed in first row). All words are read from sortedWords.txt file.
#
# Paramiters:
# - correct: Array of correct letters.
# - present: Array of present letters.
# - absent: Array of absent letters.
# - enterdWords: Array of all entered words (I know I spelled it wrong).
# - currentRow: Integer showing which row is currently played.
#
# Returns: A word which meets all criteria to be guessed.
def wordGuesser(correct, present, absent, enterdWords, currentRow)
  if File.exist?("sortedWords.txt")
    File.open("sortedWords.txt", "r") do |file|   #Open sortedWords.txt file
      file.each_line do |word|    # Loop through all lines in sortedWords.txt
        word.chomp!
        wrong = false

        i = 0

        if !enterdWords.include?(word)  # Don't guess words that is already guessed
          while i < word.length   # All correct letters need to be in the right place
            if correct[i] != nil
              if word[i] != correct[i]
                wrong = true
              end
            end

            if absent.include?(word[i])   # Word can't include any absent letter
              wrong = true
            end
          
            i += 1
          end

          present.each_entry do |presentChar|
            if !word.include?(presentChar)    # Word needs to include all present chars
              wrong = true
            else
              enterdWords.each do |enterdWord|
                if enterdWord.include?(presentChar)
                  if word.index(presentChar) == enterdWord.index(presentChar)   # The present char can't be in the same place as in a previously guessed word.
                    wrong = true
                  end
                end
              end
            end
          end

          if currentRow == 0
            if word.chars.uniq != word.chars  # The first word can't include duplicate latters
              wrong = true
            end
          end

          if wrong == false
            return word
          end
        end
      end
    end
  end
end