# coding: utf-8

require_relative 'lexical_analyzer/lexical_rule'
require_relative 'lexical_analyzer/version'

# The Ruby Compiler Toolkit Project - Lexical Analyzer
# Scan input and extract lexical tokens.

class LexicalAnalyzer

  # Access the text in the analyzer.
  attr_reader :text

  # Set things up.
  def initialize(text: "")
    @text = text
  end

  # Add some more text.
  def add_text(text)
    @text << text
  end

end
