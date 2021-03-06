/* englily-string-iterator.vala
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
  public class StringIterator {
    private unichar _current = 0;
    private string _str;
    private int _iter = 0;
    
    public unichar current { 
      get { return _current; } 
    }

    public string str {
      private get { return _str; }
      set {
        _str = value;
        reset();
      }
    }

    public bool end { get; set; }

    public StringIterator(string str = "") {
      this.str = str;
    }

    public bool next() {
      bool result = str.get_next_char(ref _iter, out _current);
      end = !result;
      return result;
    }

    public void reset() {
      _iter = 0;
      _current = 0;
      end = false;
    }

    public void skip_white_spaces() {
      
      while(current.isspace()) {
        next();
      }
    }

    public bool next_if_char(unichar c) {
      if (c == current) {
        return next();
      }
      return false;
    }
  }
}
