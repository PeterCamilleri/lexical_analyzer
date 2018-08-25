# coding: utf-8

require_relative 'lexical_analyzer/version'

# The Ruby Compiler Toolkit Project - Lexical Analyzer
# Scan input and extract lexical tokens.

class LexicalAnalyzer

  # Access the text in the analyzer.
  attr_reader :text

  # Access the array of lexical rules.
  attr_reader :rules

  # The default tokenizer block
  DTB = lambda {|symbol, value| [symbol, value] }

  # Set things up.
  def initialize(text: "", rules: [])
    @text = text
    @rules = rules
  end

  # Get the next lexical token
  def get
    rules.each do |rule|
      if match_data = text.match(rule[1])
        @text = match_data.post_match

        return (rule[2] || DTB).call(rule[0], match_data.to_s) || get
      end

    end

    false

  end

end
