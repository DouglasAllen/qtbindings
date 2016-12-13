
# !/usr/bin/env ruby
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'

#
class LCDRange < Qt::Widget
  def initialize(parent = nil)
    super
    lcd = Qt::LCDNumber.new(2)
    slider = Qt::Slider.new(Qt::Horizontal)
    slider.range = 0..99
    slider.value = 0

    lcd.connect(slider, SIGNAL('valueChanged(int)'), SLOT('display(int)'))

    layout = Qt::VBoxLayout.new
    layout.addWidget(lcd)
    layout.addWidget(slider)
    setLayout(layout)
  end
end

#
class MyWidget < Qt::Widget
  def initialize
    super
    @app = Qt::Application.new(ARGV)
    quit_button
    grid
    layout
  end

  def quit_button
    @quit = Qt::PushButton.new('Quit')
    @quit.setFont(Qt::Font.new('Times', 18, Qt::Font::Bold))
    connect(@quit, SIGNAL('clicked()'), @app, SLOT('quit()'))
  end

  def grid
    @grid = Qt::GridLayout.new
    (0..3).each do |row|
      (0..3).each do |column|
        @grid.addWidget(LCDRange.new, row, column)
      end
    end
  end

  def layout
    layout = Qt::VBoxLayout.new
    layout.addWidget(@quit)
    layout.addLayout(@grid)
    setLayout(layout)
  end
end

app = Qt::Application.new(ARGV)
widget = MyWidget.new
widget.show
app.exec
