# autosignr

#### Table of Contents

1. [Description](#description)
1. [Setup](#setup)
1. [Reference](#reference)
1. [Examples](#examples)

## Description

Installs and configures [autosignr](https://github.com/jasonhancock/autosignr).

## Setup

This module does not configure a repository for the autosignr package. You will
need to provide a repository that contains the autosignr package.

## Reference

##### `dir`
  The directory on the Puppetmaster that contains the CSRs. Defaults to
  /etc/puppetlabs/puppet/ssl/ca/requests.

##### `cmd_sign`
  The command to run when a CSR has been validated to sign a certificate. `%s`
  will be expanded to the certname. Defaults to
  `/opt/puppetlabs/bin/puppet cert sign %s`

##### `logfile`
  What file to log to. Defaults to `/var/log/autosignr/autosignr.log`.

##### `accounts_aws`
  An array of AWS credentials. See example below

##### `accounts_azure`
  An array of Azure credentials. See example below

##### `accounts_gcp`
  An array of GCP credentials. See example below

##### `preshared_keys`
  An array of preshared keys. This is optional and will be omitted from the
  autosignr configuration if not set.

## Examples

~~~puppet
class { 'autosignr':
  preshared_keys => ['psk_1', 'psk_1'],
  accounts_aws   => [
    {
      name    => 'Amazon Account 1',
      key     => 'AWS_KEY_ID',
      secret  => 'AWS_SECRET_KEY',
      regions => ['us-west-2', 'us-east-1'],
    }
  ],
  accounts_azure =>  [
    {
      name            => 'Azure Account 1',
      client_id       => 'AZURE_CLIENT_ID',
      client_secret   => 'AZURE_CLIENT_SECRET',
      subscription_id => 'AZURE_SUBSCRIPTION_ID',
      tenant_id       => 'AZURE_TENANT_ID',
    },
  ],
  accounts_gcp =>  [
    {
      name       => 'GCP Account 1',
      project_id => 'GCP PROJECT ID',
      secret     => 'GCP SECRET JSON in BASE64',
    },
  ],
}
~~~

Or specify the configuration in Hiera (and use eyaml for encrypting secrets):

~~~yaml
autosignr::accounts_aws:
  - name: Amazon Account 1
    key: >
      ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
      DQYJKoZIhvcNAQEBBQAEggEALmhWyfvIloVqx6su2kvYZgSz5r/l27ecFq1P
      x+qjMLdW8zQqwDqizklgsSHN6pffvfwrY6w/2VNtc86G7VyQIjPiaYF1fMQB
      GcTCyhxlsI/2C4gLDqElnIV5EW8uBF8Q1nutcmbYPMrbrGTzcNmtD/lQJE7t
      HcAS15gwLXans219eJZmHeQk9AdVfIpEZj90YjPqqY44qyJk1owUtxD0E+ID
      PdNJl6xMrJcZd6oghTJiaqWoPX8gShOImUH8Ul0+jlq2y5I1rW0RWjB2Bz1f
      sO8tK1iaqyCvwa0B0PXnYYyzjVlvSuE2aZ7DDY6RTw6i9tTbHHCGYS5Erqh5
      +nnH9zA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCDCjVmOJpPydVD6mBG
      hUMIgBA4+ZaUMHU0DwWvbkKQ6Eq5]
    secret: >
      ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
      DQYJKoZIhvcNAQEBBQAEggEALmhWyfvIloVqx6su2kvYZgSz5r/l27ecFq1P
      x+qjMLdW8zQqwDqizklgsSHN6pffvfwrY6w/2VNtc86G7VyQIjPiaYF1fMQB
      GcTCyhxlsI/2C4gLDqElnIV5EW8uBF8Q1nutcmbYPMrbrGTzcNmtD/lQJE7t
      HcAS15gwLXans219eJZmHeQk9AdVfIpEZj90YjPqqY44qyJk1owUtxD0E+ID
      PdNJl6xMrJcZd6oghTJiaqWoPX8gShOImUH8Ul0+jlq2y5I1rW0RWjB2Bz1f
      sO8tK1iaqyCvwa0B0PXnYYyzjVlvSuE2aZ7DDY6RTw6i9tTbHHCGYS5Erqh5
      +nnH9zA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCDCjVmOJpPydVD6mBG
      hUMIgBA4+ZaUMHU0DwWvbkKQ6Eq5]
    regions:
      - us-west-2
      - us-east-1
autosignr::accounts_azure:
  - name: Microsoft Account 1
    client_id: client_id1
    client_secret: >
      ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
      DQYJKoZIhvcNAQEBBQAEggEALmhWyfvIloVqx6su2kvYZgSz5r/l27ecFq1P
      x+qjMLdW8zQqwDqizklgsSHN6pffvfwrY6w/2VNtc86G7VyQIjPiaYF1fMQB
      GcTCyhxlsI/2C4gLDqElnIV5EW8uBF8Q1nutcmbYPMrbrGTzcNmtD/lQJE7t
      HcAS15gwLXans219eJZmHeQk9AdVfIpEZj90YjPqqY44qyJk1owUtxD0E+ID
      PdNJl6xMrJcZd6oghTJiaqWoPX8gShOImUH8Ul0+jlq2y5I1rW0RWjB2Bz1f
      sO8tK1iaqyCvwa0B0PXnYYyzjVlvSuE2aZ7DDY6RTw6i9tTbHHCGYS5Erqh5
      +nnH9zA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCDCjVmOJpPydVD6mBG
      hUMIgBA4+ZaUMHU0DwWvbkKQ6Eq5]
    subscription_id: subscription_id1
    tenant_id: tenant_id
autosignr::accounts_gcp:
  - name: Google Account1
    project_id: project_id1
    secret: >
      ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
      DQYJKoZIhvcNAQEBBQAEggEALmhWyfvIloVqx6su2kvYZgSz5r/l27ecFq1P
      x+qjMLdW8zQqwDqizklgsSHN6pffvfwrY6w/2VNtc86G7VyQIjPiaYF1fMQB
      GcTCyhxlsI/2C4gLDqElnIV5EW8uBF8Q1nutcmbYPMrbrGTzcNmtD/lQJE7t
      HcAS15gwLXans219eJZmHeQk9AdVfIpEZj90YjPqqY44qyJk1owUtxD0E+ID
      PdNJl6xMrJcZd6oghTJiaqWoPX8gShOImUH8Ul0+jlq2y5I1rW0RWjB2Bz1f
      sO8tK1iaqyCvwa0B0PXnYYyzjVlvSuE2aZ7DDY6RTw6i9tTbHHCGYS5Erqh5
      +nnH9zA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCDCjVmOJpPydVD6mBG
      hUMIgBA4+ZaUMHU0DwWvbkKQ6Eq5]
autosignr::preshared_keys:
  - >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEALmhWyfvIloVqx6su2kvYZgSz5r/l27ecFq1P
    x+qjMLdW8zQqwDqizklgsSHN6pffvfwrY6w/2VNtc86G7VyQIjPiaYF1fMQB
    GcTCyhxlsI/2C4gLDqElnIV5EW8uBF8Q1nutcmbYPMrbrGTzcNmtD/lQJE7t
    HcAS15gwLXans219eJZmHeQk9AdVfIpEZj90YjPqqY44qyJk1owUtxD0E+ID
    PdNJl6xMrJcZd6oghTJiaqWoPX8gShOImUH8Ul0+jlq2y5I1rW0RWjB2Bz1f
    sO8tK1iaqyCvwa0B0PXnYYyzjVlvSuE2aZ7DDY6RTw6i9tTbHHCGYS5Erqh5
    +nnH9zA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBCDCjVmOJpPydVD6mBG
    hUMIgBA4+ZaUMHU0DwWvbkKQ6Eq5]
~~~
