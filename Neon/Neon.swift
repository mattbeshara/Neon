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

class Neon {
    let defaults: UserDefaults = UserDefaults.standard
    let colorKey: String = "color"

    var windows: [NSWindow] = []
    var screenChangeObserver: NSObjectProtocol?

    var color: NSColor {
        get {
            defaults.data(forKey: colorKey).flatMap {
                try? NSKeyedUnarchiver.unarchivedObject(
                    ofClass: NSColor.self,
                    from: $0
                )
            }
            ?? .clear
        }

      set {
          let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            defaults.setValue(data, forKey: colorKey)
            updateColor()
      }
    }

    init() {
        registerDefaults()
        recreateWindows()
        displayColorPanel()
        observeScreenChanges()
    }

    func observeScreenChanges() {
        screenChangeObserver = NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main,
            using: { _ in self.recreateWindows() }
        )
    }

    func recreateWindows() {
        windows.forEach { $0.orderOut(nil) }
        windows = NSScreen.screens.compactMap {
            $0.createMenuBarOverlayWindow()
        }
        if windows.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.recreateWindows()
            }
            return
        }
        windows.forEach {
            self.updateColor()
            $0.orderFrontRegardless()
        }
    }

    func displayColorPanel() {
        let colorPanel = NSColorPanel.shared
        colorPanel.color = color
        colorPanel.orderFrontRegardless()
        colorPanel.isContinuous = true
        colorPanel.showsAlpha = true
        colorPanel.setTarget(self)
        colorPanel.setAction(#selector(setColor(from:)))
    }

    @objc
    func setColor(from panel: NSColorPanel) { color = panel.color }

    func updateColor() { windows.forEach { $0.backgroundColor = color } }

    func registerDefaults() {
        let color = NSColor.green.withAlphaComponent(0.5)
        let data = NSKeyedArchiver.archivedData(withRootObject: color)
        defaults.register(defaults: [colorKey: data])
    }
}
