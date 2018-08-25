# LexicalAnalyzer

WIP

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lexical_analyzer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lexical_analyzer

## Usage

The lexical analyzer is created with two keyword parameters, the text to be
analyzed and an array of rules for performing that task.

#### Rules

A rule is an array with two or three elements. These elements are:

rule[0] - a symbol that represents this rule.

rule[1] - a regular expression. This must begin with a \\A clause to ensure
correct operation of the analyzer.

rule[2] - an optional block that generates the output token that corresponds
to this rule. Some examples of these blocks are:

```ruby
# Ignore this input, emit no token.
Proc.new { false }

# The default block that is used if none is given.
lambda {|symbol, value| [symbol, value] }

# Take the text retrieved and process it further with another analyzer.
lambda {|_symbol, value| ka.set_text(value).get

```


#### Tokens

The token is also an array, with two elements.

token[0] - the symbol extracted from the rule that generated this token.

token[1] - the text that generated this token.


#### Example

The test file "lexical_analyzer_test.rb" has the method
test_some_lexical_analyzing that is a really good example of this gem in
action.

## Contributing

#### Plan A

1. Fork it ( https://github.com/PeterCamilleri/lexical_analyzer_dup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

#### Plan B

Go to the GitHub repository and raise an issue calling attention to some
aspect that could use some TLC or a suggestion or an idea.

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the LexicalAnalyzer project’s codebases, issue
trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
