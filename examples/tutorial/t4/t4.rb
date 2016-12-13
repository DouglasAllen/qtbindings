
# !/usr/bin/env ruby
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'

#
class MyWidget < Qt::Widget
  def initialize(parent = nil)
    super
    @app = Qt::Application.new(ARGV)
    setFixedSize(200, 120)

    quit = Qt::PushButton.new('Quit', self)
    quit.setGeometry(62, 40, 75, 30)
    quit.setFont(Qt::Font.new('Times', 18, Qt::Font::Bold))

    connect(quit, SIGNAL('clicked()'), @app, SLOT('quit()'))
  end
end

app = Qt::Application.new(ARGV)
widget = MyWidget.new
widget.show
app.exec
