test_sources = [
  'test-main.vala',
  'testcase.vala',
]

test_lexical_unit_parser_sources = [
    'test-lexical-unit-parser.vala'
]
test_lexical_unit_parser_sources += test_sources

test_lexical_unit_parser = executable('test-lexical-parser-unit', 
         test_lexical_unit_parser_sources,
         dependencies: [
             lib_dep
             ],
           env: [
    'G_TEST_SRCDIR=@0@'.format(meson.current_source_dir()),
    'G_TEST_BUILDDIR=@0@'.format(meson.current_build_dir()),
  ],
   vala_args: '--define=TEST_LEXICAL_UNIT_PARSER',
)

test('test-lexical-parser-unit', test_lexical_unit_parser)

test_string_iterator_sources = [
  'test-string-iterator.vala'
]
test_string_iterator_sources += test_sources

test_string_iterator = executable('test-string-iterator', 
         test_string_iterator_sources,
         dependencies: [
             lib_dep
             ],
           env: [
    'G_TEST_SRCDIR=@0@'.format(meson.current_source_dir()),
    'G_TEST_BUILDDIR=@0@'.format(meson.current_build_dir()),
  ],
  vala_args: '--define=TEST_STRING_ITERATOR',
)

test('test-string-iterator', test_string_iterator)