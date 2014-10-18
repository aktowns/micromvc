require 'tilt'
require 'tilt/erb'
require 'erb'

module Micro
  class View
    def initialize(file, scope)
      full_path = Dir[file + '.*'].first
      puts "Loading view #{full_path}"
      @tilt = Tilt.new(full_path)
      @scope = scope
    end

    def render(&content)
      @tilt.render(@scope, {}, &content)
    end
  end
end