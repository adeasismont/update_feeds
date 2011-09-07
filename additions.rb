# Borrowed from rails core

module Utilities
  module ObjectAdditions
    def returning (value)
      yield(value)
      value
    end
  end
  
  module StringAdditions
    def shorten (length = 30, end_string = '...')
      l = length - end_string.length
      (self.length > length ? self[0...l] + end_string : self).to_s
    end
  end
end

class Object
  include Utilities::ObjectAdditions
end

class String
  include Utilities::StringAdditions
end