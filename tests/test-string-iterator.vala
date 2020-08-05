/* test-string-iterator.vala
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

public class TestStringIterator : TestCase {
    
    public TestStringIterator() {
        base("TestStringIteratorTest");

        add_test("[StringIterator]: empty string iterator can't move", test_empty_string_iterator);
    }

    public void test_empty_string_iterator() {
        var iterator = new Englily.StringIterator();

        assert(iterator.next() == false);
    }
}