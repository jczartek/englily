/* englily-text-state-parser.vala
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

public class Englily.LexicalUnit.TextStateParser : BaseState {
  
  public TextStateParser(Parser parser) {
    base(parser);
  }

  public override void parse() {
    do {
      if (iterator.current == '<') {
        this.parser.current_state = Tag;
        return;
      } else if (iterator.current == '&') {
        this.parser.current_state = Symbol;
        return;
      } else {
        scheme.append_unichar(iterator.current);
      }
    } while (iterator.next());
    this.parser.current_state = End;
  }
}
