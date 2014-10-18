require 'pry'
module Micro
  module Decorators
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def initialize_decorators
      self.class.helpers.each do |x|
        extend x
      end
    end

    module ClassMethods
      def decorators(xs=nil)
        if xs.nil?
          @def_decorators ||= []
        else
          xs = [xs] if xs.class != Array
          @def_decorators = xs
        end
      end
      alias_method :decorator, :decorators
    end
  end
end
