require 'fileutils'

module Micro::Generator
  class Initial
    include FileUtils

    GEMFILE = <<-EOF
      source 'https://rubygems.org'

      gem 'micromvc', path: '~/RubymineProjects/micromvc'
    EOF

    def initialize(dir)
      @dir = dir
    end

    def make_folders
      %w(controllers decorators helpers models views).each do |appfolder|
        mkdir_p File.join(@dir, 'app', appfolder)
      end
      %w(initializers tasks).each do |libfolder|
        mkdir_p File.join(@dir, 'lib', libfolder)
      end
      mkdir_p File.join(@dir, 'config')

      IO.write(strip_heredoc(GEMFILE), File.join(@app, 'Gemfile'))
    end

    private

    def strip_heredoc(str)
      indent = str.scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
      str.gsub(/^[ \t]{#{indent}}/, '')
    end
  end
end