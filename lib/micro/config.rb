require 'ostruct'

module Micro
  class Config < OpenStruct
    def self.shared
      @@shared ||= Config.new
    end
  end
end