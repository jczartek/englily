/* englily-symbol-state-parser.vala
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

public class Englily.LexicalUnit.SymbolStateParser : BaseState {
  
  public SymbolStateParser(Parser parser) {
    base(parser);
  }

  private string extract_html_symbol() {

    var builder = new StringBuilder();
    unichar c = iterator.current;

    while (iterator.next() && c != ';') {
      builder.append_unichar(c);
      c = iterator.current;
    }

    return builder.str;
  }

  private void add_symbol_to_scheme(string html_symbol) {
    string symbol = Helper.get_html_symbol(html_symbol);
    scheme.append_text(symbol);
  }

  public override void parse() {
   var html_symbol = extract_html_symbol();
   add_symbol_to_scheme(html_symbol);
   this.parser.current_state = Text;
  }
}
