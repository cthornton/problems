# Require this file. Includes autoloading
require 'rubygems'
require 'bundler'

require 'active_support/dependencies'

# Autoload the lib directory
ActiveSupport::Dependencies.autoload_paths += [File.join(__dir__, 'lib')]
