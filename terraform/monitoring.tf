resource "datadog_monitor" "healthcheck" {
  name    = "healthcheck"
  type    = "service check"
  query   = "\"http.can_connect\".over(\"*\").by(\"*\").last(3).count_by_status()"
  message = "App server healthcheck"
}