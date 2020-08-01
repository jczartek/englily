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

public class LexicalUnitParserTests : TestCase
{
  public LexicalUnitParserTests()
  {
    base("LexicalUnitParser");
    
    add_test("[LexicalUnitParser] parse raw text", test_parse_raw_text);
  }
  
  public void test_parse_raw_text()
  {
    var parser = new Englily.LexicalUnitParser("raw text");
    parser.parse();
    
    var lexical_unit = parser.scheme.get_lexical_unit();
    
    assert(lexical_unit == "raw text");
  }
  
}