
# !/usr/bin/env ruby
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'
require 'lcdrange.rb'
require 'cannon.rb'

#
class MyWidget < Qt::Widget
  def initialize(parent = nil)
    super
    @app = Qt::Application.new(ARGV)
    quit_button
    angle_display
    field
    grid
  end

  def quit_button
    @quit = Qt::PushButton.new('Quit')
    @quit.setFont(Qt::Font.new('Times', 18, Qt::Font::Bold))
    connect(@quit, SIGNAL('clicked()'), @app, SLOT('quit()'))
  end

  def angle_display
    @angle = LCDRange.new(self)
    @angle.range = 5..70
    @angle.setValue(60)
    @angle.setFocus
  end

  def field
    @cannon_field = CannonField.new(self)

    connect(@angle, SIGNAL('valueChanged(int)'),
            @cannon_field, SLOT('setAngle(int)'))
    connect(@cannon_field, SIGNAL('angleChanged(int)'),
            @angle, SLOT('setValue(int)'))
  end

  def grid
    grid_layout = Qt::GridLayout.new
    grid_layout.addWidget(@quit, 0, 0)
    grid_layout.addWidget(@angle, 1, 0)
    grid_layout.addWidget(@cannon_field, 1, 1, 2, 1)
    grid_layout.setColumnStretch(1, 10)
    setLayout(grid_layout)
  end
end

a = Qt::Application.new(ARGV)

w = MyWidget.new
w.setGeometry(100, 100, 500, 355)
w.show
a.exec
