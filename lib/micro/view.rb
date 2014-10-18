require 'tilt'
require 'tilt/erb'
require 'erb'

module Micro
  class View
    def initialize(file)
      full_path = Dir[file + '.*'].first
      puts "Loading view #{full_path}"
      @tilt = Tilt.new(full_path)
    end

    def render(&content)
      @tilt.render(&content)
    end
  end
end