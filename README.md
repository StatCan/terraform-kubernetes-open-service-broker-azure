# Terraform Kubernetes Open Service Broker for Azure

## Introduction

This module deploys and configures Open Service Broker for Azure inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage

```terraform
module "helm_open_service_broker_azure" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-open-service-broker-azure?ref=20191009.1"

  chart_version = "1.8.3"
  dependencies = [
    "${module.namespace_osba.depended_on}",
  ]

  helm_namespace = "${module.namespace_osba.depended_on}"
  helm_repository = "azure"

  values = <<EOF

EOF
```

## Variables Values

| Name                 | Type   | Required | Value                                               |
| -------------------- | ------ | -------- | --------------------------------------------------- |
| chart_version        | string | yes      | Version of the Helm Chart                           |
| dependencies         | string | yes      | Dependency name refering to namespace module        |
| helm_namespace       | string | yes      | The namespace Helm will install the chart under     |
| helm_repository      | string | yes      | The repository where the Helm chart is stored       |
| values               | list   | no       | Values to be passed to the Helm Chart               |

## History

| Date     | Release    | Change                                                     |
| -------- | ---------- | ---------------------------------------------------------- |
| 20190729 | 20190729.1 | Improvements to documentation and formatting               |
| 20190909 | 20190909.1 | 1st release                                                |
| 20200605 | v2.0.0     | Module now modified for Helm 3                             |