# Ignore vendored code.
exclude_paths = ["vendor/**/*"]

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'
PuppetLint.configuration.ignore_paths = exclude_paths

require 'puppet-syntax/tasks/puppet-syntax'
PuppetSyntax.exclude_paths = exclude_paths

task :default => [
  :syntax,
  :lint,
  :spec,
]
