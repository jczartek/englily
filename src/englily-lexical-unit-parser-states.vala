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

using GLib;
using Gydict;

namespace Englily {

  public enum State {
    End,
    Err,
    Text,
    SYMBOL,
    TAG
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
      while (iterator.next())
      {
        if (iterator.current == '<')
          this.parser.current_state = End;
        else if (iterator.current == '&')
          this.parser.current_state = End;
        else
          scheme.append_unichar(iterator.current);
      }
      this.parser.current_state = End;
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

