# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }
}

resource "helm_release" "service_catalog" {
  depends_on = ["null_resource.dependency_getter"]
  name = "service-catalog"
  repository = "${var.helm_repository_service_catalog}"
  chart = "catalog"
  version = "${var.chart_version_service_catalog}"
  namespace = "${var.helm_namespace}"
}

resource "helm_release" "osba" {
  depends_on = ["helm_release.service_catalog", "null_resource.dependency_getter"]
  name = "osba"
  repository = "${var.helm_repository}"
  chart = "open-service-broker-azure"
  version = "${var.chart_version}"
  namespace = "${var.helm_namespace}"

  values = [
    "${var.values}",
  ]
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "helm_release.service_catalog",
    "helm_release.osba",
  ]
}
