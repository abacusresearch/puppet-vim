# == Class: vim::params
#
class vim::params {
  $package_name = $facts['os']['family'] ? {
    default => 'vim',
  }

  $package_list = $facts['os']['family'] ? {
    default => undef,
  }

  $config_dir_path = $facts['os']['family'] ? {
    'RedHat'  => '/etc',
    default => '/etc/vim',
  }

  $config_file_path = $facts['os']['family'] ? {
    'RedHat'  => '/etc/vimrc',
    default => '/etc/vim/vimrc',
  }

  $config_file_owner = $facts['os']['family'] ? {
    default => 'root',
  }

  $config_file_group = $facts['os']['family'] ? {
    default => 'root',
  }

  $config_file_mode = $facts['os']['family'] ? {
    default => '0644',
  }

  $config_file_require = $facts['os']['family'] ? {
    default => 'Package[vim]',
  }
}
