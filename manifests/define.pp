# == Define: vim::define
#
define vim::define (
  Optional[Stdlib::Absolutepath] $config_file_path         = undef,
  Optional[String] $config_file_owner                      = undef,
  Optional[String] $config_file_group                      = undef,
  Optional[String] $config_file_mode                       = undef,
  Optional[String] $config_file_source                     = undef,
  Optional[String] $config_file_string                     = undef,
  Optional[String] $config_file_template                   = undef,

  Optional[String] $config_file_require                    = undef,

  Hash $config_file_options_hash                           = $::vim::config_file_options_hash,
) {
  $_config_file_path  = pick($config_file_path, "${::vim::config_dir_path}/${name}")
  $_config_file_owner = pick($config_file_owner, $::vim::config_file_owner)
  $_config_file_group = pick($config_file_group, $::vim::config_file_group)
  $_config_file_mode = pick($config_file_mode, $::vim::config_file_mode)
  $config_file_content = extlib::default_content($config_file_string, $config_file_template)

  $_config_file_require = pick($config_file_require, $::vim::config_file_require)

  file { "define_${name}":
    ensure  => $::vim::config_file_ensure,
    path    => $_config_file_path,
    owner   => $_config_file_owner,
    group   => $_config_file_group,
    mode    => $_config_file_mode,
    source  => $config_file_source,
    content => $config_file_content,
    require => $_config_file_require,
  }
}
