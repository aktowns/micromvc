require 'tilt'
require 'tilt/erb'
require 'erb'

module Micro
  class View
    def initialize(file)
      full_path = Dir[file + '.*'].first
      @tilt = Tilt.new(full_path)
    end

    def render
      @tilt.render
    end
  end
end