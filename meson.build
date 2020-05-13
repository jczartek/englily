project('englily', ['c', 'vala'],
          version: '0.1.0',
    meson_version: '>= 0.50.0',
  default_options: [ 'warning_level=2',
                   ],
)

datadir   = join_paths(get_option('prefix'), get_option('datadir'), 'gydict', 'plugins')
schemadir = join_paths(get_option('prefix'), get_option('datadir'), 'glib-2.0', 'schemas')
moduledir = join_paths(get_option('prefix'), 'lib')

cc = meson.get_compiler('c')
vapi_dir = '/opt/gydict/share/vala/vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.24'),
  dependency('libgydict-1.0'),
  dependency('libpeas-1.0', version: '>= 1.22.0'),
  dependency('libdazzle-1.0', version: '>= 3.26.0'),
  cc.find_library('z', required: true),
]

subdir('data')
subdir('src')

meson.add_install_script ('data//post-install.sh')

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
