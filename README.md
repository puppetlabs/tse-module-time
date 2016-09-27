# time

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Example usage code with description](#example)
4. [Parameters](#parameters)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview

This module is designed as a wrapper for two modules: one that manages the Windows time servers, while the other is the standard Puppet NTP module for \*nix systems. 

##Module Description

This module requires the [winntp](https://github.com/jpadams/winntp) and [ntp](https://forge.puppet.com/puppetlabs/ntp) modules that are found at their appropriate links. 

##Usage

###Basic OS default example
In this example the windows/\*nix servers will ensure that time syncronization is occuring to their default servers:
```puppet
  include 'time'
```
###Example of setting the time servers to two custom addresses
In this example the two servers that are passed as variables will be set on all servers
```puppet
  class { 'time':
    servers => ['time.nist.gov', 'north-america.pool.ntp.org'],
  }
```

##Parameters

The following parameters are available in the `::time` class:

###`servers` (optional)
Specifies the time servers to be set.  
Valid Input: Array of strings

##Limitations
The module is compatiable with Linux and Windows machines.
