require 'test/unit'
require File.dirname(__FILE__) + "/../lib/human_codes"

class TestHumanCodes < Test::Unit::TestCase

  include HumanCodes
  
  def test_fixnum_becomes_string
    assert_kind_of String, 45.human_code
  end
  
  def test_bignum_becomes_string
    assert_kind_of String, 231087934571049032.human_code
  end
  
  def test_string_becomes_bignum
    assert_kind_of Bignum, 'AHEATZZTAJBC43JZY'.human_code
  end
  
  def test_string_allows_optional_auto_upcasing
    assert_kind_of Fixnum, 'abh56ak'.human_code(:fix_case => true)
  end
  
  def test_string_does_not_automatically_upcase
    assert_kind_of String, 'abh56ak'.human_code
  end
  
  def test_string_becomes_fixnum
    assert_kind_of Fixnum, 'J'.human_code
  end
  
  def test_invalid_string_returns_self
    string = 'Whoah there!'
    assert_equal string, string.human_code
  end
  
  def test_identities
    [123, 90000008, 733, '12331', 'abYzj', '0', 'A', 'z',
     79823898923232, 'ZZZZZZZZZZZZZZZZZZZ', 'Yz82J3Ng5Nj9M1',
     '!!!', '@$%!^', 'abc ', 'HP', 4, 'ǟ'].each do |object|
      assert_equal object, object.human_code.human_code
    end
  end

  def test_only_human_scannable_characters_should_validate
    alphabet = ['2','3','4','5','6','7','8','9',
                'A','B','C','D','E','F','G','H','J','K','M',
                'N','P','Q','R','S','T','U','V','W','X','Y','Z'].map {|char| char[0] }
    (0..255).each do |i|
      case
        when alphabet.include?(i)
           assert i.chr.is_human_code?, "char #{i} is not valid as string #{i.chr}"
        else
           assert !i.chr.is_human_code?, "char #{i} is valid as string #{i.chr}"
      end
    end 
  end

  def test_edge_62_to_the_0_convertions_should_be_valid
    (0...62).each do |i|
      encode = i.human_code
      decode = encode.human_code
      assert_equal i, decode, "integer #{i} was encoded as #{encode} and was decoded to #{decode}"
    end
  end

  def test_edge_62_to_the_n_convertions_should_be_valid
    (0...3).each do |p|
      n = 62 ** p
      (0...62).each do |i|
        encode = (i+n).human_code
        decode = encode.human_code
        assert_equal i+n, decode, "interger #{i+n} was encoded as #{encode} and was decoded to #{decode}"
      end
    end
  end
end
