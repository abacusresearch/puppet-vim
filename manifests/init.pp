# == Class: vim
#
class vim (
  Enum['absent','latest','present','purged'] $package_ensure           = 'present',
  String $package_name             = $::vim::params::package_name,
  Optional[Array] $package_list             = $::vim::params::package_list,

  Optional[Stdlib::Absolutepath] $config_dir_path          = $::vim::params::config_dir_path,
  Boolean $config_dir_purge         = false,
  Boolean $config_dir_recurse       = true,
  Optional[String] $config_dir_source        = undef,

  Optional[Stdlib::Absolutepath] $config_file_path         = $::vim::params::config_file_path,
  String $config_file_owner        = $::vim::params::config_file_owner,
  String $config_file_group        = $::vim::params::config_file_group,
  String $config_file_mode         = $::vim::params::config_file_mode,
  Optional[String] $config_file_source       = undef,
  Optional[String] $config_file_string       = undef,
  Optional[String] $config_file_template     = undef,

  String $config_file_require      = $::vim::params::config_file_require,

  Hash $config_file_hash         = {},
  Hash $config_file_options_hash = {},

  $background               = 'dark',
  $default_editor           = true,
) inherits ::vim::params {
  $config_file_content = default_content($config_file_string, $config_file_template)

  if $config_file_hash {
    create_resources('vim::define', $config_file_hash)
  }

  if $package_ensure == 'purged' {
    $config_dir_ensure  = 'absent'
    $config_file_ensure = 'absent'
  } else {
    $config_dir_ensure  = 'directory'
    $config_file_ensure = 'present'
  }

  asser_type(Enum['absent','directory'], $config_dir_ensure )
  asser_type(Enum['absent','present'], $config_file_ensure )

  anchor { 'vim::begin': } ->
  class { '::vim::install': } ->
  class { '::vim::config': } ->
  anchor { 'vim::end': }
}
