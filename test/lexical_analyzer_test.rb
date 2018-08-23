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
    assert(LexicalRule.is_a?(Class))
  end

  def test_that_it_has_properties
    la = LexicalAnalyzer.new(text: "A B C")
    assert_equal("A B C", la.text)
  end
end
