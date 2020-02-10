# Class: autosignr
# ===========================
#
# Installs and configures [autosignr](https://github.com/jasonhancock/autosignr)
#
# Parameters
# ----------
#
# * `dir`
# The directory on the Puppetmaster that contains the CSRs. Defaults to
# /etc/puppetlabs/puppet/ssl/ca/requests.
#
# * `cmd_sign`
# The command to run when a CSR has been validated to sign a certificate. `%s`
# will be expanded to the certname. Defaults to
# `/opt/puppetlabs/bin/puppet cert sign %s`
#
# * `logfile`
# What file to log to. Defaults to `/var/log/autosignr/autosignr.log`.
#
# * `accounts_aws`
# An array of AWS credentials. See example below
# 
# * `accounts_azure`
# An array of Azure credentials.  See example below
#
# * `accounts_gcp`
# An array of GCP credentials. See example below
#
# * `preshared_keys`
# An array of preshared keys. This is optional and will be omitted from the
# autosignr configuration if not set.
#
# Examples
# --------
#
# @example
#    class { 'autosignr':
#      preshared_keys => ['psk_1', 'psk_1'],
#      accounts_aws   => [
#        {
#          name    => 'Amazon Account 1',
#          key     => 'AWS_KEY_ID',
#          secret  => 'AWS_SECRET_KEY',
#          regions => ['us-west-2', 'us-east-1'],
#        },
#      ],
#      accounts_azure =>  [
#        {
#          name            => 'Azure Account 1',
#          client_id       => 'AZURE_CLIENT_ID',
#          client_secret   => 'AZURE_CLIENT_SECRET',
#          subscription_id => 'AZURE_SUBSCRIPTION_ID',
#          tenant_id       => 'AZURE_TENANT_ID',
#        },
#      ],
#      accounts_gcp =>  [
#        {
#          name       => 'GCP Account 1',
#          project_id => 'GCP PROJECT ID',
#          secret     => 'GCP SECRET JSON in BASE64',
#        },
#      ],
#    }
#
# Authors
# -------
#
# Jason Hancock <jason at jasonhancock dot com>
#
# Copyright
# ---------
#
# Copyright 2016 Jason Hancock
#
class autosignr (
  $dir = '/etc/puppetlabs/puppet/ssl/ca/requests',
  $cmd_sign = '/opt/puppetlabs/bin/puppet cert sign %s',
  $logfile = '/var/log/autosignr/autosignr.log',
  $accounts_aws = [],
  $accounts_azure = [],
  $accounts_gcp = [],
  $preshared_keys = [],
) {

  package { 'autosignr':
    ensure => latest,
    notify => Service['autosignr'],
  }

  file { '/etc/autosignr/config.yaml':
    content => template("${module_name}/config.yaml.erb"),
    mode    => '0400',
    require => Package['autosignr'],
    notify  => Service['autosignr'],
  }

  each($accounts_gcp) | $detail | {
    file { "/etc/autosignr/gcp_${detail['project_id']}.json":
      content => base64('decode', $detail['secret']),
      mode    => '0400',
      require => Package['autosignr'],
      notify  => Service['autosignr'],
    }
  }

  service { 'autosignr':
    ensure  => 'running',
    enable  => 'true',
    require => File['/etc/autosignr/config.yaml'],
  }
}
