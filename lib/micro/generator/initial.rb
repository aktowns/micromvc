require 'fileutils'

module Micro::Generator
  class Initial
    include FileUtils

    GEMFILE = <<-EOF
      source 'https://rubygems.org'

      gem 'micromvc', path: '~/RubymineProjects/micromvc'
    EOF

    DEMO_CONTROLLER = <<-EOF
      class DemoController < Micro::Controller
        root '/'

        index do
          render 'Hello, World!'
        end
      end
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
      mkdir_p File.join(@dir, 'app', 'views', 'layouts')

      IO.write(File.join(@dir, 'Gemfile'), strip_heredoc(GEMFILE))
      IO.write(File.join(@dir, 'app','controllers', 'demo_controller.rb'), strip_heredoc(DEMO_CONTROLLER))
    end

    def bundle_install
      exec "cd #{@dir} && bundle install"
    end

    private

    def strip_heredoc(str)
      str.gsub(/^#{str[/\A\s*/]}/, '')
    end
  end
end