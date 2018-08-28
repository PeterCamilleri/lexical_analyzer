# The Ruby Compiler Toolkit Project - Lexical Analyzer
# Scan input and extract lexical tokens.

require_relative 'lexical_analyzer/version'

class LexicalAnalyzer
  attr_accessor :text   # Access the text in the analyzer.
  attr_reader   :rules  # Access the array of lexical rules.

  # Some array index values.
  SYMBOL = 0
  REGEX  = 1
  BLOCK  = 2

  # The default tokenizer block
  DTB = lambda {|symbol, value| [symbol, value] }

  # Set things up.
  def initialize(text: "", rules: [])
    @text  = text
    @rules = rules
  end

  # Get the next lexical token
  def get
    rules.each do |rule|
      if match_data = text.match(rule[REGEX])
        @text = match_data.post_match
        return (rule[BLOCK] || DTB).call(rule[SYMBOL], match_data.to_s) || get
      end
    end

    false
  end
end
