require 'pry'
module Micro
  module Helpers
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def initialize_helpers
      self.class.helpers.each do |x|
        extend x
      end
    end

    module ClassMethods
      def helpers(xs=nil)
        if xs.nil?
          @def_helpers ||= []
        else
          xs = [xs] if xs.class != Array
          @def_helpers = xs
        end
      end
      alias_method :helper, :helpers
    end
  end
end
