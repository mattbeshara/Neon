// Copyright 2021 Matt Beshara.
//
// This file is part of Neon.
//
// Neon is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Neon is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Neon.  If not, see <https://www.gnu.org/licenses/>.

import Cocoa

extension NSScreen {
    var menuBarFrame: NSRect {
        NSRect(
            x: 0,
            y: frame.size.height - NSApp.menuBarHeight,
            width: frame.size.width,
            height: NSApp.menuBarHeight
        )
    }

    func createMenuBarOverlayWindow() -> NSWindow {
        let window = NSWindow(
            contentRect: menuBarFrame,
            styleMask: .borderless,
            backing: .buffered,
            defer: false,
            screen: self
        )

      window.canHide = false
      window.collectionBehavior = [
        .canJoinAllSpaces,
        .transient,
        .ignoresCycle,
        .fullScreenNone
      ]
      window.level = .screenSaver - 1
      window.ignoresMouseEvents = true

      return window
    }
}
