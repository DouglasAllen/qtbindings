# !/usr/bin/env ruby
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
# ** Translated to QtRuby by Richard Dale# **
$VERBOSE = true
$LOAD_PATH.unshift File.dirname($PROGRAM_NAME)

require 'Qt'
# require './qrc_systray.rb'
require 'window.rb'

app = Qt::Application.new(ARGV)

unless Qt::SystemTrayIcon.isSystemTrayAvailable
  Qt::MessageBox.critical(nil, Qt::Object.tr('Systray'),
                          Qt::Object.tr("I couldn't detect any system tray " \
                                        'on this system.'))
  exit 1
end

window = Window.new
window.show
app.exec
