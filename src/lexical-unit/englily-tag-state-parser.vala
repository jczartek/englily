/* englily-tag-state-parser.vala
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

using Gee;
using Gydict;

public class Englily.LexicalUnit.TagStateParser : BaseState {
  
  public TagStateParser(Parser parser) {
    base(parser);
  }
  
  public override void parse() {
    var tag = create_tag();
    this.parser.current_state = ParserState.Text;
  }
  
  private Tag create_tag() {
    var tag = Tag();
    iterator.next(); // move iter behind '<'
    iterator.skip_white_spaces();
    tag.is_closed = is_closed();
    iterator.skip_white_spaces();
    extract_tag_info(tag);
    return tag;
  }
  
  private bool is_closed() {
    bool result = false;
    
    if (iterator.current == '/') {
      result = true;
      iterator.next();
    }
    return result;
  }
  
  private void extract_tag_info (Tag tag) {
    var builder = new StringBuilder();
    
    while (iterator.current != '>' && iterator.current != ' ') {
      builder.append_unichar(iterator.current);
      iterator.next();
    }
    tag.name = builder.str;
    iterator.skip_white_spaces();
    
    if (iterator.next_if_char('>') || iterator.end) {
      if (iterator.end) {
        this.parser.current_state = End;
      }
      return;
    } 
    extract_tag_attrs(tag);
  }
  
  private void extract_tag_attrs(Tag tag) {
    
    var attr_name = extract_attr_name();
    iterator.skip_white_spaces();
    iterator.next(); // move iter behind '='
    iterator.skip_white_spaces();
    var attr_value = extract_attr_value();
    
    tag[attr_name] = attr_value;
    
    iterator.skip_white_spaces();
    if (iterator.current == '>') {
      iterator.next();
      return;
    }
    
    extract_tag_attrs(tag);
  }
  
  private string extract_attr_name() {
    var attr_name = new StringBuilder();
    
    while (iterator.current != '=') {
      
      if (iterator.current.isspace()) {
        iterator.next();
        continue;
      }
      
      attr_name.append_unichar(iterator.current);
      iterator.next();
    }
    return attr_name.str;
  }
  
  private string extract_attr_value() {
    var attr_value = new StringBuilder();
    
    while (iterator.current != '>' && iterator.current != ' ') {
      
      if (iterator.current != '"') {
        iterator.next();
        continue;
      }
      
      attr_value.append_unichar(iterator.current);
      iterator.next();
    }
    return attr_value.str;
  }
  
  private struct Tag {
    public string name { get; set; }
    public HashMap<string,string> args;
    public bool is_closed {get; set; }
    
    public string get(string key) {
      if (args == null) {
        args = new HashMap<string, string>();
      }
      
      return args[key];
    }
    
    public void set(string key, string value) {
      if (args == null) {
        args = new HashMap<string, string>();
      }
      
      args[key] = value;
    }
  }
}
