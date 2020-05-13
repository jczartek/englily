/* englily-dict-service.vala
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

namespace Englily {
  public class DictServiceImpl : Object, Gy.Service, Gy.DictService {

    public string service_id { get; private set; }

    private Gtk.TreeModel model;

    public DictServiceImpl(string service_id) {
      this.service_id = service_id;
    }

    public unowned Gtk.TreeModel get_model() {
      return model;
    }

    public Gy.DictDataScheme? parse(string text_to_parse) {
      return null;
    }

    public string get_lexical_unit(uint idx) {
      return "";
    }

    public unowned string get_service_id() {
      return service_id;
    }
  }
}
