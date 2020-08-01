# Generate configuration class
local_config = configuration_data()
local_config.set('schemadir', schemadir)

configuration = configure_file(
    input: 'englily-config.vala.in',
    output: 'englily-config.vala',
    configuration: local_config
)

gnome = import('gnome')
resources = gnome.compile_resources(
  'englily-resource',
  'englily.gresource.xml',
)

sources = [
  'englily.vala',
  'englily-app.vala',
  'englily-win.vala',
  'englily-prefs.vala',
   configuration,
  'englily-dict-formatter.vala',
  'englily-dict-service.vala',
  'englily-helper.vala',
  'englily-string-iterator.vala',
  'englily-list-parser.vala',
  'englily-lexical-unit-parser.vala',
  'englily-lexical-unit-parser-states.vala',
]

sources += resources

lib = shared_library('englily', sources,
  dependencies: deps,
       install: true,
   install_dir: moduledir)


static_lib_sources = [
  'englily-string-iterator.vala',
  'englily-lexical-unit-parser.vala',
  'englily-lexical-unit-parser-states.vala'
]


static_lib = static_library('englily-static', static_lib_sources,
  dependencies: deps,
       install: false)

lib_dep = declare_dependency(
            dependencies: [
              dependency('gio-2.0', version: '>= 2.50'),
              dependency('gee-0.8', version: '>= 0.20.0'),
              dependency('libgydict-1.0', required: true),
            ],
            include_directories: include_directories('.'),
               link_with: static_lib,
)

install_data('englily.plugin',
  install_dir: moduledir)

