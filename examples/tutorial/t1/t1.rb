
# !/usr/bin/env ruby
$VERBOSE = true; $LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'

a = Qt::Application.new(ARGV)
hello = Qt::PushButton.new('Hello World!', nil)
hello.resize(100, 30)
hello.show
a.exec
