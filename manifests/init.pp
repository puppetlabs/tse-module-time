class time (
    # set basic params
    Array[String] $servers = ['time.example.com'],
    Integer $special_poll_interval    = 900, # 15 minutes
    Integer $max_pos_phase_correction = 54000, # 15 hrs
    Integer $max_neg_phase_correction = 54000, # 15 hrs
    Boolean $purge_unmanaged_servers  = true,
) {

  notify {"what time is it? \n":}

  case $::kernal {
      'Linux': {

        notify {"Linux Time! \n":}

        class { '::ntp':
          servers => $servers,
        }
      }


      'windows': {

        notify {"windows Time! \n":}

        $ntp_servers = join(suffix($servers, ',0x09'), ' ')

        registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\Type':
          type => 'string',
          data => 'NTP',
          notify => Service['w32time'],
         }

        # the list of servers in required space-delimited string format
        registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\NtpServer':
            type => 'string',
            data => $ntp_servers,
            notify => Service['w32time'],
          }
          
        registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient\SpecialPollInterval':
            ensure => present,
            type   => 'dword',
            data   => $special_poll_interval,
            notify => Service['w32time'],
        }

        registry_key { 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers':
          ensure       => present,
          purge_values => $purge_unmanaged_servers,
        }

        # create a new numbered registry value for each ntp server (1 to $servers.length) 
        $servers.each |$index, $srv| { 
          $i = $index + 1
          registry_value { "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\DateTime\\Servers\\${i}":
            ensure => present,
            type   => 'string',
            data   => $srv,
            notify => Service['w32time'],
          }
        }

        # default setting is first ntp server (server 1)
        registry_value { 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers\\':
          ensure => present,
          type   => 'string',
          data   => '1',
          notify => Service['w32time'],
        }
        
        registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config\MaxPosPhaseCorrection':
          ensure => present,
          type   => 'dword',
          data   => $max_pos_phase_correction,
          notify => Service['w32time'],
        }

        registry_value { 'HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config\MaxNegPhaseCorrection':
          ensure => present,
          type   => 'dword',
          data   => $max_neg_phase_correction,
          notify => Service['w32time'],
        }

        service { 'w32time':
          ensure => running,
          enable => true,



        }
      }
    }

  }
