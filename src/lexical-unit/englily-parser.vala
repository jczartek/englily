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

using Gydict;
using Gee;

public class Englily.LexicalUnit.Parser : Object 
{
  public FormatScheme scheme { get; private set; }
  public StringIterator iterator { get; private set; }
  
  public HashMap<ParserState, IState> states { get; private set; }
  public ParserState current_state { get; set; }
  
  public Parser(string unparse_lexical_unit) requires(unparse_lexical_unit != "")
  {
    scheme = new FormatScheme();
    iterator = new StringIterator.with_string(unparse_lexical_unit);
    iterator.next();
    current_state = ParserState.Text;
    
    states = new HashMap<ParserState, IState>();
    states[ParserState.End] = new EndStateParser(this);
    states[ParserState.Text] = new TextStateParser(this);
    states[ParserState.Symbol] = new SymbolStateParser(this);
    states[ParserState.Tag] = new TagStateParser(this);
  }
  
  public void parse()
  {
    while(current_state != ParserState.End)
    {
      states[current_state].parse();
    }
  }
}

