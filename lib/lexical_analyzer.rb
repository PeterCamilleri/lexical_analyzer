# coding: utf-8

require_relative 'lexical_analyzer/version'

# The Ruby Compiler Toolkit Project - Lexical Analyzer
# Scan input and extract lexical tokens.

class LexicalAnalyzer

  # Access the text in the analyzer.
  attr_reader :text

  # Access the array of lexical rules.
  attr_reader :rules

  # Set things up.
  def initialize(text: "", rules: [])
    @text = text
    @rules = rules
  end

end
