package pagerduty

skip[msg] {
  data.system.abbey.identities.abbey.pagerduty.is_on_call
  msg := sprintf("skipping oncall: %v", [data.system.abbey.identities.abbey.pagerduty.is_on_call])
}
