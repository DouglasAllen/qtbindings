
# **
# ** Copyright (C) 2004-2005 Trolltech AS. All rights reserved.
# **
# ** This file is part of the example classes of the Qt Toolkit.
# **
# ** This file may be used under the terms of the GNU General Public
# ** License version 2.0 as published by the Free Software Foundation
# ** and appearing in the file LICENSE.GPL included in the packaging of
# ** this file.  Please review the following information to ensure GNU
# ** General Public Licensing requirements will be met:
# ** http://www.trolltech.com/products/qt/opensource.html
# **
# ** If you are unsure which license is appropriate for your use, please
# ** review the following information:
# ** http://www.trolltech.com/products/qt/licensing.html or contact the
# ** sales department at sales@trolltech.com.
# **
# ** This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
# ** WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
# **
#
# ** Translated to QtRuby by Richard Dale
class Dialog < Qt::Dialog
  NUM_GRID_ROWS = 3
  NUM_BUTTONS = 4

  def initialize
    super
    setWindowTitle(tr('Basic Layouts'))
    menu_bar
    horizontal_box
    grid_box
    big_editor
    buttons
    layout
  end

  def big_editor
    @big_editor = Qt::TextEdit.new
    @big_editor.setPlainText(
      tr('This widget takes up all the remaining space ' \
         'in the top-level layout.')
    )
  end

  def buttons
    @ok_button = Qt::PushButton.new(tr('OK'))
    @cancel_button = Qt::PushButton.new(tr('Cancel'))
    @ok_button.default = true

    connect(@ok_button, SIGNAL('clicked()'), self, SLOT('accept()'))
    connect(@cancel_button, SIGNAL('clicked()'), self, SLOT('reject()'))

    @button_layout = Qt::HBoxLayout.new do |b|
      b.addStretch(1)
      b.addWidget(@ok_button)
      b.addWidget(@cancel_button)
    end
  end

  def layout
    self.layout = Qt::VBoxLayout.new do |m|
      m.menuBar = @menu_bar
      m.addWidget(@horizontal_group_box)
      m.addWidget(@grid_group_box)
      m.addWidget(@big_editor)
      m.addLayout(@button_layout)
    end
  end

  def menu_bar
    @menu_bar = Qt::MenuBar.new

    @file_menu = Qt::Menu.new(tr('&File'), self)
    @exit_action = @file_menu.addAction(tr('E&xit'))
    @menu_bar.addMenu(@file_menu)

    connect(@exit_action, SIGNAL('triggered()'), self, SLOT('accept()'))
  end

  def horizontal_box
    @buttons = []
    @horizontal_group_box = Qt::GroupBox.new(tr('Horizontal layout'))
    @button_layout = Qt::HBoxLayout.new

    (0...NUM_BUTTONS).each do |i|
      @buttons[i] = Qt::PushButton.new(tr('Button %d' + (i + 1).to_s))
      @button_layout.addWidget(@buttons[i])
    end
    @horizontal_group_box.layout = @button_layout
  end

  def grid_rows
    @labels = []
    @line_edits = []
    (0...NUM_GRID_ROWS).each do |i|
      line_str = 'Line %d:' + (i + 1).to_s
      @labels[i] = Qt::Label.new(tr(line_str))
      @line_edits[i] = Qt::LineEdit.new
      @grid_layout.addWidget(@labels[i], i, 0)
      @grid_layout.addWidget(@line_edits[i], i, 1)
    end
  end

  def small_editor
    @small_editor = Qt::TextEdit.new
    @small_editor.setPlainText(
      tr('This widget takes up about two thirds of the ' \
         'grid layout.')
    )
  end

  def grid_box
    @grid_group_box = Qt::GroupBox.new(tr('Grid layout'))
    @grid_layout = Qt::GridLayout.new
    grid_rows
    small_editor
    @grid_layout.addWidget(@small_editor, 0, 2, 3, 1)
    @grid_layout.setColumnStretch(1, 10)
    @grid_layout.setColumnStretch(2, 20)
    @grid_group_box.layout = @grid_layout
  end
end

Qt::Application.new(ARGV)
