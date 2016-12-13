
# !/usr/bin/env ruby
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'

require 'lcdrange.rb'

#
class MyWidget < Qt::Widget
  def initialize(parent = nil)
    super(parent)
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
    previous_range = nil
    (0..3).each do |row|
      col(previous_range, row)
    end
  end

  def col(pr, row)
    (0..3).each do |column|
      lcd_range = LCDRange.new(self)
      @grid.addWidget(lcd_range, row, column)
      unless pr.nil?
        connect(lcd_range, SIGNAL('valueChanged(int)'),
                pr, SLOT('setValue(int)'))
      end
      pr = lcd_range
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
