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

extension NSApplication {
    var menuBarHeight: CGFloat? { Self.shared.mainMenu?.menuBarHeight }
}
