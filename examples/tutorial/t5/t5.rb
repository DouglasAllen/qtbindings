
# !/usr/bin/env ruby
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'

#
class MyWidget < Qt::Widget
  def initialize
    super
    @app = Qt::Application.new(ARGV)
    quit_button
    lcd_display
    slider_control
    layout
  end

  def quit_button
    @quit = Qt::PushButton.new('Quit')
    @quit.setFont(Qt::Font.new('Times', 18, Qt::Font::Bold))
    connect(@quit, SIGNAL('clicked()'), @app, SLOT('quit()'))
  end

  def lcd_display
    @lcd = Qt::LCDNumber.new(2)
  end

  def slider_control
    @slider = Qt::Slider.new(Qt::Horizontal)
    @slider.range = 0..99
    @slider.value = 0
    connect(@slider, SIGNAL('valueChanged(int)'),
            @lcd, SLOT('display(int)'))
  end

  def layout
    @layout = Qt::VBoxLayout.new
    @layout.addWidget(@quit)
    @layout.addWidget(@lcd)
    @layout.addWidget(@slider)
    setLayout(@layout)
  end
end

app = Qt::Application.new(ARGV)
widget = MyWidget.new
widget.show
app.exec
