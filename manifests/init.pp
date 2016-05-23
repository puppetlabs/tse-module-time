class time (
  Optional[Array[String]] $servers = undef,
) {
  case $::kernel {
    'windows': {
      class { 'winntp':
        servers => $servers,
      }
    }
    default: {
      class { 'ntp':
        servers => $servers,
      }
    }
  }
}
