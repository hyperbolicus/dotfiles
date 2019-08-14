Configuration Files
===================

WIP

Using Saltstack
===============

To execute the configuration, use `salt-call -c $(pwd) --local --pillar-root ~/.pillar`

An example for a necessary configuration is:

```

mbsync:
  - name: <Name> # Where password is stored in pass
    host: <Hostaddress for mbsync>
    user: <user>
```
