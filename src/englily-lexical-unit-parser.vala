/* englily-lexical-unit-parser.vala
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

using GLib;
using Gydict;
using Gee;

namespace Englily {
  
  public class LexicalUnitParser : Object 
  {
    public FormatScheme scheme { get; private set; }
    public StringIterator iterator { get; private set; }

    public HashMap<State, IState> states { get; private set; }
    public State current_state { get; set; }

    public LexicalUnitParser(string unparse_lexical_unit)
    {
      scheme = new FormatScheme();
      iterator = new StringIterator.with_string(unparse_lexical_unit);
      current_state = State.Text;

      states = new HashMap<State, IState>();
      states[State.End] = new EndStateParser(this);
      states[State.Text] = new TextStateParser(this);
      states[State.Symbol] = new SymbolStateParser(this);
    }

    public void parse()
    {
      while(current_state != State.End && current_state != State.Err)
      {
        states[current_state].parse();
      }
    }
  }
}
