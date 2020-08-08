/* test-lexical-unit-parser.vala
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

public class LexicalUnitParserTests : TestCase {
  public LexicalUnitParserTests() {
    base("LexicalUnitParser");
    
    add_test("[LexicalUnitParser] parse lexical unit as raw text", test_parse_raw_text);
    add_test("[LexicalUnitParser] parse lexical unit as symbol html", test_parse_lexical_unit_as_symbol);
    add_test("[LexicalUnitParser] parse lexical unit as symbols", test_parse_lexical_unit_as_symbols);
    add_test("[LexicalUnitParser] parse lexical unit as symbols surrounded by text", test_parse_lexical_unit_as_symbols_surrounded_by_text);
    add_test("[LexicalUnitParser] parse lexical unit as symbols interspersed with text", test_parse_lexical_unit_as_symbols_interspersed_with_text);
    add_test("[LexicalUnitParser] parse lexical unit as unknown symbol", test_parse_lexical_unit_as_unknown_symbol);
    add_test("[LexicalUnitParser] parse lexical unit with a formatting tag", test_parse_lexical_unit_with_formatting_tag);
    add_test("[LexicalUnitParser] parse lexical unit with formatting tags",  test_parse_lexical_unit_with_formatting_tags);
    add_test("[LexicalUnitParser] parse lexical unit as text and tags interspersed with space",test_parse_lexical_unit_text_and_tags_interspersed_with_spaces);
    add_test("[LexicalUnitParser] parse lexical unit as tag with attr", test_parse_lexical_unit_as_tag_with_attr);
    add_test("[LexicalUnitParser] parse lexical unit as tag with attrs", test_parse_lexical_unit_as_tag_with_attrs);
    add_test("[LexicalUnitParser] parse lexical unit with hangingpar", test_parse_lexical_unit_with_hangingpar_tag);
  }
  
  public void test_parse_raw_text() {
    var parser = new Englily.LexicalUnit.Parser("raw text");
    parser.parse();
    
    var lexical_unit = parser.scheme.get_lexical_unit();
    
    assert(lexical_unit == "raw text");
  }

  public void test_parse_lexical_unit_as_symbol() {
    const string input = "&dollar;";
    var parser = new Englily.LexicalUnit.Parser(input);
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();

    assert("$" == lexical_unit);
  }

  public void test_parse_lexical_unit_as_symbols() {
    const string input = "&##9553;&oboczn;&##1100;&##1098;&s172;&ytilde;";
    const string expected = "║║ьъ←ỹ";
    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();

    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_as_symbols_surrounded_by_text () {
    const string input = "xxx&##9553;&oboczn;&##1100;&##1098;&s172;&ytilde;xxx";
    const string expected = "xxx║║ьъ←ỹxxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_as_symbols_interspersed_with_text() {
    const string input = "xxx&##9553;xyz&oboczn;xyz&##1100;xyz&##1098;xyz&s172;xyz&ytilde;xxx";
    const string expected = "xxx║xyz║xyzьxyzъxyz←xyzỹxxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_as_unknown_symbol() {
    const string input = "&unknownSymbol;";
    const string expected = "<unknown>";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_with_formatting_tag() {
    const string input = "<BIG>xxxx</BIG>";
    const string expected = "xxxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_with_formatting_tags() {
    const string input = "<BIG><B>xxxx</B></BIG>";
    const string expected = "xxxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_text_and_tags_interspersed_with_spaces() {
    const string input = "< BIG >< B >xxxx< / B >< / BIG>";
    const string expected = "xxxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_as_tag_with_attr() {
    const string input ="<A HREF=\"12\">xxx</A>";
    const string expected = "xxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_as_tag_with_attrs() {
    const string input ="<ICON ID=\"0\" HREF=\"12\">xxx</ICON>";
    const string expected = "xxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    assert(expected == lexical_unit);
  }

  public void test_parse_lexical_unit_with_hangingpar_tag() {
    const string input ="xxx<HANGINGPAR>xxx";
    const string expected = "xxx\txxx";

    var parser = new Englily.LexicalUnit.Parser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    message(lexical_unit);
    assert(expected == lexical_unit);
  }
  
}