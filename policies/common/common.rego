package common

import data.abbey.functions

allow[msg] {
    functions.expire_after("2m")
    msg := "granting access for 5 minutes"
}
