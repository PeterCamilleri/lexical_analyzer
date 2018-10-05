# The Ruby Compiler Toolkit Project - Lexical Rule
# A rule for lexical analysis.

# The RCTP class for lexical rules.
class LexicalRule
  attr_reader :symbol  # Read access to the rule's symbol.
  attr_reader :regex   # Read access to the rule's regex.

  # Create a lexical rule.
  def initialize(symbol, regex, &action)
    @symbol = symbol
    @regex  = regex

    define_singleton_method(:call, &action) if block_given?
  end

  # Does this rule match?
  def match(text)
    text.match(@regex)
  end

  # The default rule action.
  def call(value)
    [symbol, value]
  end
end
