require 'sequel'

module Micro
  class Model < Sequel::Model
    include Micro::Decorators

    def initialize

    end
  end
end