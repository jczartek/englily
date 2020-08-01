test_sources = [
    'test-main.vala',
    'testcase.vala',
    'test-lexical-unit-parser.vala',
]

englily_tests = executable('englily-tests', 
         test_sources,
         dependencies: [
             lib_dep
             ],
           env: [
    'G_TEST_SRCDIR=@0@'.format(meson.current_source_dir()),
    'G_TEST_BUILDDIR=@0@'.format(meson.current_build_dir()),
  ],
)

test('englily-test', englily_tests)
