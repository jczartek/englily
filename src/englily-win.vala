/* englily-win.vala
 *
 * Copyright 2020 Jakub Czartek <kuba@linux.pl>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Gydict;

namespace Englily {
  public class WinAddinImpl : Object, WindowAddin {
    private uint menu_id = 0;

    public void load(Window win) {
      try {
        menu_id = win.add_menu_by_resource("/plugin/englily/gtk/menus.ui");
      }
      catch (Error e) {
        critical("Error: %s\n", e.message);
      }
    }

    public void unload(Window win) {
      if (menu_id != 0) {
        win.remove_menu(menu_id);
      }
    }
  }
}
