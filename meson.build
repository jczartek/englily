project('englily', ['c', 'vala'],
          version: '0.1.0',
    meson_version: '>= 0.50.0',
  default_options: [ 'warning_level=2',
                   ],
)

datadir   = join_paths(get_option('prefix'), get_option('datadir'), 'gydict', 'plugins')
schemadir = join_paths(get_option('prefix'), get_option('datadir'), 'glib-2.0', 'schemas')
moduledir = join_paths(get_option('prefix'), 'lib')

libgydict_dep = dependency('libgydict-1.0', required: true)

vapidir = libgydict_dep.get_pkgconfig_variable('vapidir')
add_project_arguments(['--vapidir', vapidir], language: 'vala')

# Add our custom VAPI dir
add_project_arguments(
  ['--vapidir', meson.source_root() / 'vapi'],
  '--disable-since-check',
  language: 'vala'
)

deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.24'),
  libgydict_dep,
  dependency('libpeas-1.0', version: '>= 1.22.0'),
  dependency('libdazzle-1.0', version: '>= 3.26.0'),
  dependency('gee-0.8', version: '>= 0.20.0'),
  dependency('zlib', version: '>= 1.2.0'),
]

subdir('data')
subdir('src')
subdir('tests')

meson.add_install_script ('data/post-install.sh')

status = [
  '',
  'englily @0@'.format(meson.project_version()),
  'version ............... : @0@'.format(meson.project_version()),
  'prefix ................ : @0@'.format(get_option('prefix')),
  'module dir ............ : @0@'.format(moduledir),
  'data dir .............. : @0@'.format(datadir),
  'schema dir ............ : @0@'.format(schemadir)
]

message('\n'.join(status))
