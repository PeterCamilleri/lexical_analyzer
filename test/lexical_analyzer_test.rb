require_relative '../lib/lexical_analyzer'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class LexicalAnalyzerTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_it_has_a_version_number
    refute_nil ::LexicalAnalyzer::VERSION
    assert(::LexicalAnalyzer::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::LexicalAnalyzer::VERSION)
  end

  def test_that_key_classes_exist
    assert(LexicalAnalyzer.is_a?(Class))
    assert(LexicalRule.is_a?(Class))
  end

  def test_that_it_has_properties
    la = LexicalAnalyzer.new(text: "A B C", rules: [4])
    assert_equal("A B C", la.text)

    la.text << " D E F"
    assert_equal("A B C D E F", la.text)

    assert_equal([4], la.rules)

    la.rules <<  5
    assert_equal([4,5], la.rules)

    la = LexicalAnalyzer.new(text: "Hello", rules: [4])
    assert_equal("Hello", la.text)
  end

  def test_some_lexical_analyzing
    # The source code to be analyzed.
    text   = <<-END_OF_SOURCE
                if (big==42)
                  cat = 99;
                END_OF_SOURCE

    # Set up the keyword sub analyzer.
    keywords = [LexicalRule.new(:if, /\Aif\z/),
                LexicalRule.new(:identifier, /.+/)
               ]

    ka = LexicalAnalyzer.new(rules: keywords)

    # Set up the main analyzer.
    rules  = [ LexicalRule.new(:spaces, /\A\s+/) { |_value| false },
               LexicalRule.new(:lparen,     /\A\(/ ),
               LexicalRule.new(:rparen,     /\A\)/ ),
               LexicalRule.new(:semicolon,  /\A;/  ),
               LexicalRule.new(:equality,   /\A==/ ),
               LexicalRule.new(:assignment, /\A=/  ),
               LexicalRule.new(:integer,    /\A\d+/) { |value|
                 [symbol, value.to_i]
               },
               LexicalRule.new(:identifier, /\A[a-zA-Z_]\w*(?=\W|$|\z)/) { |value|
                 ka.renew(text: value).get
               }
             ]

    la = LexicalAnalyzer.new(text: text, rules: rules)

    # The values we expect to get.
    values = [ [:if,        "if"  ],
               [:lparen,     "("  ],
               [:identifier, "big"],
               [:equality,   "==" ],
               [:integer,    42   ],
               [:rparen,     ")"  ],
               [:identifier, "cat"],
               [:assignment, "="  ],
               [:integer,    99   ],
               [:semicolon,  ";"  ],
               false
             ]

    # Run the tests.
    values.each do |value|
      assert_equal(value, la.get)
    end
  end

  def test_with_extra_rules
    # The source code to be analyzed.
    text   = "123"

    rules  = [ LexicalRule.new(:one,    /\A1/ ),
               LexicalRule.new(:two,    /\A2/ )
             ]

    extra  = [ LexicalRule.new(:three,  /\A3/ )]

    la = LexicalAnalyzer.new(text: text, rules: rules)

    # The values we expect to get.
    values = [ [:one,   "1" ],
               [:two,   "2" ],
               [:three, "3" ],
               false ]

    # Run the tests.
    values.each do |value|
      assert_equal(value, la.get(extra))
    end
  end

end
