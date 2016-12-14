
require 'Qt'
#
class CannonField < Qt::Widget
  signals 'angle_changed(int)'
  slots 'set_angle(int)'

  def initialize(parent = nil)
    super
    @current_angle = 45
    setPalette(Qt::Palette.new(Qt::Color.new(250, 250, 200)))
    setAutoFillBackground(true)
  end

  def angle(degrees)
    if degrees < 5
      degrees = 5
    elsif degrees > 70
      degrees = 70
    end
    return if @current_angle == degrees
    @current_angle = degrees
    repaint
    emit angle_changed(@current_angle)
  end

  def paint_event(_event)
    p = Qt::Painter.new(self)
    p.drawText(200, 200, 'Angle = %d' + @current_angle.to_s)
    p.end
  end

  def size_policy
    Qt::SizePolicy.new(Qt::SizePolicy::Expanding, Qt::SizePolicy::Expanding)
  end
end
