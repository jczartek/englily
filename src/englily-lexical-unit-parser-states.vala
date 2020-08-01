/* englily-lexical-unit-parser-states.vala
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

  public enum State {
    End,
    Err,
    Text,
    Symbol,
    Tag
  }

  public interface IState : Object {
    public abstract State state { get; set; }
    public abstract void parse();
  }

  public abstract class BaseState : Object, IState {
    public State state { get; set; }
    protected weak LexicalUnitParser parser { get; private set; }
    protected StringIterator iterator;
    protected FormatScheme scheme;
    
    protected BaseState(State state, LexicalUnitParser parser)
    {
      this.state = state;
      this.parser = parser;
      this.iterator = parser.iterator;
      this.scheme = parser.scheme;
    }
    
    public abstract void parse();
  }

  public class TextStateParser : BaseState
  {
    public TextStateParser(LexicalUnitParser parser)
    {
      base(Text, parser);
    }

    public override void parse()
    {
      do {
        if (iterator.current == '<') {
          assert_not_reached ();
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

  public class SymbolStateParser : BaseState
  {
    public SymbolStateParser(LexicalUnitParser parser)
    {
      base(Symbol, parser);
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

  public class EndStateParser : BaseState
  {
    public EndStateParser(LexicalUnitParser parser)
    {
      base(End, parser);
    }

    public override void parse()
    {
    }
  }
}

