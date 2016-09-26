# time

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - Installation and dependencies](#setup)
4. [Example - Example usage code with description](#example)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview

This module is designed as a wrapper for two modules: one that manages the Windows time servers, while the other is the standard Puppet NTP module for \*nix systems. 

##Module Description

This module requires the [winntp](https://github.com/jpadams/winntp) and [ntp](https://github.com/puppetlabs/puppetlabs-ntp) modules that are found at their appropriate links. 

##Setup


##Example
```puppet
  include 'time'

  class { 'winntp':
    servers => ['time.windows.com', 'time.nist.gov', 'north-america.pool.ntp.org'],
  }
```

##Limitations
The module is compatiable with Linux and Windows machines.
