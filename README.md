slickmotd
=========
slickmotd generates a slick looking motd

It requires figlet to generate the ANSI art text based on the fantastic
"Bloody" font by xero (https://github.com/xero/figlet-fonts)

It also needs git to clone the repo above.

Flags/Options
-------------

Flag/Option   | Description
------------- | -------------
`-c`          | Enable color output (default: enabled)
`-n`          | Disable color output
`-u`          | Enable uptime output for use in dynamic motd (default: disabled)
`-s`          | Specify a signature or quote (defaults to "enjoy your stay")
`-h`          | Specify the short hostname (defaults to `hostname -a`)
`-d`          | Specify the domain name (defaults to `hostname -d`)
`-x`          | Specify how many columns to use for output (default: 80)
`-y`          | Specify how many rows to use for output (default: 25)

Examples
--------

`./slickmotd.sh`
```



                ▒██   ██▒ ██▓▓█████▄  ▄▄▄▄    ▒█████  ▒██   ██▒
                ▒▒ █ █ ▒░▓██▒▒██▀ ██▌▓█████▄ ▒██▒  ██▒▒▒ █ █ ▒░
                ░░  █   ░▒██▒░██   █▌▒██▒ ▄██▒██░  ██▒░░  █   ░
                 ░ █ █ ▒ ░██░░▓█▄   ▌▒██░█▀  ▒██   ██░ ░ █ █ ▒
                ▒██▒ ▒██▒░██░░▒████▓ ░▓█  ▀█▓░ ████▓▒░▒██▒ ▒██▒
                ▒▒ ░ ░▓ ░░▓   ▒▒▓  ▒ ░▒▓███▀▒░ ▒░▒░▒░ ▒▒ ░ ░▓ ░
                ░░   ░▒ ░ ▒ ░ ░ ▒  ▒ ▒░▒   ░   ░ ▒ ▒░ ░░   ░▒ ░
                 ░    ░   ▒ ░ ░ ░  ░  ░    ░ ░ ░ ░ ▒   ░    ░
                 ░    ░   ░     ░     ░          ░ ░   ░    ░
                              ░            ░

                             ┌                    ┐
         · ··  ·  · ·· ──────┤ xidbox.localdomain ├────── ·· ·  ·  ·· ·
                             └                    ┘
                                enjoy your stay





```

`./slickmotd.sh -n -u -h "euclid" -d "theore.ms" -s "If q is prime, then there is at least one more prime that is not in the list."`
```



                 ▓█████  █    ██  ▄████▄   ██▓     ██▓▓█████▄
                 ▓█   ▀  ██  ▓██▒▒██▀ ▀█  ▓██▒    ▓██▒▒██▀ ██▌
                 ▒███   ▓██  ▒██░▒▓█    ▄ ▒██░    ▒██▒░██   █▌
                 ▒▓█  ▄ ▓▓█  ░██░▒▓▓▄ ▄██▒▒██░    ░██░░▓█▄   ▌
                 ░▒████▒▒▒█████▓ ▒ ▓███▀ ░░██████▒░██░░▒████▓
                 ░░ ▒░ ░░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░░ ▒░▓  ░░▓   ▒▒▓  ▒
                  ░ ░  ░░░▒░ ░ ░   ░  ▒   ░ ░ ▒  ░ ▒ ░ ░ ▒  ▒
                    ░    ░░░ ░ ░ ░          ░ ░    ▒ ░ ░ ░  ░
                    ░  ░   ░     ░ ░          ░  ░ ░     ░
                                 ░                     ░

                              ┌                  ┐
          · ··  ·  · ·· ──────┤ euclid.theore.ms ├────── ·· ·  ·  ·· ·
                              └                  ┘
      22:51:26 up 13 days, 13:34,  0 users,  load average: 0.00, 0.01, 0.00

 If q is prime, then there is at least one more prime that is not in the list.




```
