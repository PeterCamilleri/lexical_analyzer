# coding: utf-8

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
    assert(/^\d+\.\d+\.\d+/ =~ ::LexicalAnalyzer::VERSION)
  end

  def test_that_key_classes_exist
    assert(LexicalAnalyzer.is_a?(Class))
  end

  def test_that_it_has_properties
    la = LexicalAnalyzer.new(text: "A B C", rules: [4])
    assert_equal("A B C", la.text)

    la.text << " D E F"
    assert_equal("A B C D E F", la.text)

    assert_equal([4], la.rules)

    la.rules <<  5
    assert_equal([4,5], la.rules)

    assert_equal(la, la.set_text("Hello"))
    assert_equal("Hello", la.text)
  end

  def test_some_lexical_analyzing
    text   = <<-END_OF_SOURCE
                if (big==42)
                  cat = 99;
                END_OF_SOURCE

    rules  = [[:spaces,     /\A\s+/, Proc.new { false }],
              [:lparen,     /\A\(/],
              [:rparen,     /\A\)/],
              [:semicolon,  /\A;/],
              [:equality,   /\A==/],
              [:assignment, /\A=/],
              [:integer,    /\A\d+/ ],
              [:identifier, /\A[a-zA-Z_]\w*(?=\W|$|\z)/]
             ]

    values = [[:identifier, "if"  ],
              [:lparen,     "("  ],
              [:identifier, "big"],
              [:equality,   "==" ],
              [:integer,    "42" ],
              [:rparen,     ")"  ],
              [:identifier, "cat"],
              [:assignment, "="  ],
              [:integer,    "99" ],
              [:semicolon,  ";"  ],
              false
             ]

    la = LexicalAnalyzer.new(text: text, rules: rules)

    values.each do |value|
      assert_equal(value, la.get)
    end
  end

end
