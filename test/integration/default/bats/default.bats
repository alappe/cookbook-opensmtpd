#!/usr/bin/env bats

@test "configuration should be written" {
  [ -e /etc/smtpd.conf ]
}

@test "smtpd should be running" {
  [ "$(ps aux | grep smtpd)" ]
}

@test "smtpd should be listening" {
  [ "$(netstat -plant | grep smtpd | grep 25)" ]
}
