# horenso_setlock

Ansible role for installing [Songmu/horenso](https://github.com/Songmu/horenso), [moznion/go\-setlock](https://github.com/moznion/go-setlock) and [slack\_reporter\.pl](https://gist.github.com/acidlemon/f8faacd20e575fff05cf67a254ab6bc7). with wrapper shell scripts.

## Requirements

none.

## Role Variables

* slack_endpoint: slack incomming webhook url for "slack_reporter.pl". if you will use "slack_reporter.pl", "h.sh" and "hl.sh", you MUST define "slack_endpoint".
* slack_channel: default channel for slack_reporter.pl.

## Dependencies

none.

## Example Playbook

```
- hosts: servers
  vars:
    slack_endpoint: https://hooks.slack.com/services/xxxxxxx
    slack_channel: '#horenso_channel'
  roles:
    - role: sasasin.horenso_setlock
```

## License

MIT

## Author Information

* [sasasin \(Shinnosuke Suzuki\)](https://github.com/sasasin)
