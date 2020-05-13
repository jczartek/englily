# Generate configuration class
local_config = configuration_data()
local_config.set('schemadir', schemadir)

configuration = configure_file(
    input: 'englily-config.vala.in',
    output: 'englily-config.vala',
    configuration: local_config
)

sources = [
  'englily.vala',
  'englily-app.vala',
  'englily-win.vala',
  'englily-prefs.vala',
   configuration,
  'englily-dict-service.vala',
]


lib = shared_library('englily', sources,
  dependencies: deps,
       install: true,
   install_dir: moduledir)


install_data('englily.plugin',
  install_dir: moduledir)

