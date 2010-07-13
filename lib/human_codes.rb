module HumanCodes
  SAFE_NUMBERS = '2','3','4','5','6','7','8','9'
  SAFE_LETTERS = 'A','B','C','D','E','F','G','H','J','K','M','N','P','Q','R','S','T','U','V','W','X','Y','Z'
  SAFE_BASE    = SAFE_NUMBERS.size + SAFE_LETTERS.size
  SAFE_CHARACTERS_AS_ASCII =
      [SAFE_NUMBERS + SAFE_LETTERS].flatten.inject({}) do |hash, char|
        hash[char[0]] = hash.size
        hash
      end
  SAFE_CHARACTERS_AS_STRINGS = [
          SAFE_NUMBERS.map {|char| char },
          SAFE_LETTERS.map {|char| char }
        ].flatten

  module Number
    def human_code
      return self if nil? || self <= 0
      string = ""
      value = self
      until value == 0
        mod = value % SAFE_BASE
        string << SAFE_CHARACTERS_AS_STRINGS[mod]
        value = value / SAFE_BASE
      end
      string.reverse
    end
  end
  
  module String
    def human_code(options = {})
      return upcase.human_code if options[:fix_case]
      return self unless is_human_code?
      val = 0
      key = reverse
      (0...key.size).each do |i|
        char = key[i]
        integer = SAFE_CHARACTERS_AS_ASCII[char]
        val = val + (integer * (SAFE_BASE ** i))
      end
      val
    end
    
    def is_human_code?
      return false if nil?
      string = self.dup
      return false if string.length <= 0
      (0...string.size).each do |i|
        return false unless SAFE_CHARACTERS_AS_ASCII[string[i]]
      end
      true
    end
  end
end

class String
  include HumanCodes::String
end
class Fixnum
  include HumanCodes::Number
end
class Bignum
  include HumanCodes::Number
end
