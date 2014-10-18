require 'tilt'
require 'tilt/erb'
require 'erb'

module Micro
  class View
    def initialize(file, scope)
      full_path = File.exist?(file) ? file : View.find_view(file)

      puts "Loading view #{full_path}"
      @tilt = Tilt.new(full_path)
      @scope = scope
    end

    def render(&content)
      @tilt.render(@scope, {}, &content)
    end


    def self.find_view(path)
      Dir[path + '.*'].first
    end
  end
end