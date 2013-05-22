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

@test "aliases file should be written" {
  [ "$(grep Chef /etc/aliases)" ]
}

@test "default mapping should be in aliases" {
  [ "$(grep 'postmaster: root' /etc/aliases)" ]
}

@test "db should be created" {
  [ -e /etc/aliases.db ]
}

@test "user _smtpd should be created" {
  [ "$(id _smtpd)" ]
}

@test "user _smtpf should be created" {
  [ "$(id _smtpf)" ]
}

@test "user _smtpq should be created" {
  [ "$(id _smtpq)" ]
}
