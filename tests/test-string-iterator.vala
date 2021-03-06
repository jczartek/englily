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
        add_test("[StringIterator]: move string iterator to next char", test_move_string_iterator_next_char);
        add_test("[StringIterator]: reset string iterator", test_reset_string_iterator);
        add_test("[StringIterator]: skip white spaces", test_skip_white_spaces);
        add_test("[StringIterator]: move iterator if char", test_move_string_iterator_if_char);
    }

    public void test_empty_string_iterator() {
        var iterator = new Englily.StringIterator();

        assert(iterator.next() == false);
        assert_true(iterator.end);
    }

    public void test_move_string_iterator_next_char() {
        var iterator = new Englily.StringIterator("xyz");

        assert(iterator.next());
        assert(iterator.current == 'x');
        assert(iterator.next());
        assert(iterator.current == 'y');
        assert(iterator.next());
        assert(iterator.current == 'z');
        assert_false(iterator.next());
        assert_true(iterator.end);
    }

    public void test_reset_string_iterator() {
        var iterator = new Englily.StringIterator("xyz");

        assert(iterator.next());
        assert(iterator.current == 'x');
        assert(iterator.next());
        assert(iterator.current == 'y');
        assert(iterator.next());
        assert(iterator.current == 'z');
        assert(iterator.next() == false);

        iterator.reset();

        assert(iterator.next());
        assert(iterator.current == 'x');
        assert(iterator.next());
        assert(iterator.current == 'y');
        assert(iterator.next());
        assert(iterator.current == 'z');
        assert_false(iterator.next());
        assert_true(iterator.end);
    }

    public void test_skip_white_spaces() {
        var iterator = new Englily.StringIterator("   x  y   z");

        iterator.next();
        
        iterator.skip_white_spaces();
        assert(iterator.current == 'x');
        assert(iterator.next());
        iterator.skip_white_spaces();
        assert(iterator.current == 'y');
        assert(iterator.next());
        iterator.skip_white_spaces();
        assert(iterator.current == 'z');
        assert_false(iterator.next());
        assert_true(iterator.end);
    }

    public void test_move_string_iterator_if_char() {
        var iterator = new Englily.StringIterator("xyz");
        iterator.next();

        assert(iterator.current == 'x');
        assert(iterator.next_if_char('x'));
        assert(iterator.current == 'y');
        assert_false(iterator.next_if_char('q'));
        assert(iterator.current == 'y');
        assert_true(iterator.next_if_char('y'));
        assert(iterator.current == 'z');
        assert_false(iterator.next_if_char('z'));
        assert_true(iterator.end);
    }
}