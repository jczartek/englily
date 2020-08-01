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
  }
  
  public void test_parse_raw_text() {
    var parser = new Englily.LexicalUnitParser("raw text");
    parser.parse();
    
    var lexical_unit = parser.scheme.get_lexical_unit();
    
    assert(lexical_unit == "raw text");
  }

  public void test_parse_lexical_unit_as_symbol() {
    const string input = "&dollar;";
    var parser = new Englily.LexicalUnitParser(input);
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();

    assert("$" == lexical_unit);
  }

  public void test_parse_lexical_unit_as_symbols() {
    const string input = "&##9553;&oboczn;&##1100;&##1098;&s172;&ytilde;";
    const string expected = "║║ьъ←ỹ";
    var parser = new Englily.LexicalUnitParser(input); 
    parser.parse();

    var lexical_unit = parser.scheme.get_lexical_unit();
    message(lexical_unit);
    assert(expected == lexical_unit);
  }
  
}