class time (
    # set basic params
    Array[String] $servers = ['time.example.com'],
) {
  case $::kernel {
    'Linux': {
      class { 'ntp':
        servers => $servers,
      }
    }
    'windows': {
      class { 'winntp':
        servers => $servers,
      }
    }
    default: {
      notify {'OS Kernal did not match any listed.':}
    }
  }
}
