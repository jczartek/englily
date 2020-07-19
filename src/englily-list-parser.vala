/* englily-list-parser.vala
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
  public interface IStateList : GLib.Object
  {
    public abstract void parse();
  }

  private class EndState : GLib.Object, IStateList
  {
    public void parse() { assert_not_reached (); }
  }

  private class NormalState : GLib.Object, IStateList
  {
    private weak ListParser list_parser;

    public NormalState(ListParser list_parser)
    {
      this.list_parser = list_parser;
    }

    public void parse()
    {
      var iter = list_parser.iterator;

      list_parser.current_state = list_parser.end_state;
      while(iter.next())
      {
        if (iter.current == '&')
        {
          list_parser.current_state = list_parser.html_symbol_state;
          break;
        }
        else if (iter.current == '<')
        {
          list_parser.current_state = list_parser.tag_state;
          break;
        }
        else
          list_parser.builder.append_unichar(iter.current);
      }
    }
  }

  private class HtmlSymbolState : GLib.Object, IStateList
  {
    private weak ListParser list_parser;
    private StringBuilder symbol_builder;

    public HtmlSymbolState(ListParser list_parser)
    {
      this.list_parser = list_parser;
      symbol_builder = new StringBuilder();
    }

    public void parse()
    {
      var iter = list_parser.iterator;

      for(; iter.current != ';'; iter.next())
      {
        symbol_builder.append_unichar(iter.current);
      }
      var symbol = Helper.get_html_symbol(symbol_builder.str);

      if (symbol != null)
        list_parser.builder.append(symbol);

      list_parser.current_state = list_parser.normal_state;
      symbol_builder.truncate();
    }
  }

  private class TagState : GLib.Object, IStateList
  {
    private weak ListParser list_parser;

    public TagState(ListParser list_parser)
    {
      this.list_parser = list_parser;
    }

    private void go_end_tag(StringIterator iter)
    {
      while (iter.current != '>' && iter.next()) ;
    }

    public void parse()
    {
      var iter = list_parser.iterator;
      list_parser.current_state = list_parser.normal_state;

      go_next_char(iter);
      skip_whitespace(iter);

      if (iter.current == '/')
      {
        go_end_tag(iter);
        return;
      }

      var tag_name = extract_tag_name(iter);

      if ("sup" == tag_name.down())
      {
        go_next_char(iter);
        if (iter.current == '&')
        {
          list_parser.current_state = list_parser.html_symbol_state;
          return;
        }
        else if(iter.current.isdigit())
        {
          var ss = Helper.get_superscript((int) iter.current - 48);
          list_parser.builder.append(ss);
        }
      }
      else
      {
        go_end_tag(iter);
      }
    }

    private void skip_whitespace(StringIterator iter)
    {
      while(iter.current.isspace() && iter.next()) ;
    }

    private void go_next_char(StringIterator iter)
    {
      if (!iter.next()) assert_not_reached();
    }

    private string extract_tag_name(StringIterator iter)
    {
      var tag_name = new StringBuilder();

      while(iter.current != ' ' && iter.current != '>')
      {
        tag_name.append_unichar(iter.current);
        go_next_char(iter);
      }

      return tag_name.str;
    }
  }

  public class ListParser : GLib.Object
  {
    public IStateList normal_state {get; private set;}
    public IStateList html_symbol_state {get; private set;}
    public IStateList tag_state {get; private set;}
    public IStateList end_state {get; private set;}
    public weak IStateList current_state {get; set;}
    public StringIterator iterator {get; private set;}
    private string _str;
    public string string_to_parse
    {
      get { return _str; }
      set
      {
        _str = value;
        iterator.str = value;
        reset();
      }
    }
    public StringBuilder builder;

    public ListParser()
    {
      normal_state = new NormalState(this);
      html_symbol_state = new HtmlSymbolState(this);
      tag_state = new TagState(this);
      end_state = new EndState();
      iterator = new StringIterator();
      builder = new StringBuilder();
    }

    public void parse()
    {
      current_state = normal_state;
      while(!(current_state is EndState))
        current_state.parse();
    }

    public void reset()
    {
      current_state = normal_state;
      builder.truncate();
    }

    public string to_string()
    {
      return builder.str;
    }
  }
}
