# The Ruby Compiler Toolkit Project - Lexical Analyzer
# Scan input and extract lexical tokens.

require_relative 'lexical_analyzer/lexical_rule'
require_relative 'lexical_analyzer/version'

# The RCTP class for lexical analysis.
class LexicalAnalyzer
  attr_reader   :text   # Access the text in the analyzer.
  attr_reader   :rules  # Access the array of lexical rules.

  # Set things up.
  def initialize(text: "", rules: [])
    @text  = text
    @rules = rules
  end

  # Reuse an existing lexical analyzer.
  def renew(text: @text, rules: @rules)
    @text  = text
    @rules = rules
    self
  end

  # Get the next lexical token
  def get(extra=[])
    (rules + extra).each do |rule|
      if match_data = rule.match(text)
        @text = match_data.post_match
        return rule.call(match_data.to_s) || get
      end
    end

    false
  end
end
