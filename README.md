slickmotd
=========
slickmotd generates a slick looking motd

Dependencies
------------
- `figlet` - to generate the ANSI art text
- `xero/figlet-fonts` - for the "Bloody" font (https://github.com/xero/figlet-fonts)
- `git` - to clone the figlet-fonts repo

Nix Flakes
----------
If you're using flakes:
`nix run github:x123/slickmotd#`

Usage
-------------
```
$ slickmotd --help
slickmotd - generate a slick looking motd

Options:
      --help          print usage
  -c, --color         enable color output     (default: enabled)
  -n, --no-color      disable color output
  -u, --uptime        enable uptime output    (default: disabled)
  -s, --signature     set signature quote     (default: "enjoy your stay")
  -h, --hostname      set short hostname      (default: autodetect)
  -d, --domain        set domain              (default: autodetect)
  -x, --width         set width in columns    (default: 80)
  -y, --height        set height in rows      (default: 25)

```

Examples
--------
`slickmotd -n --hostname "euclid" --domain "theore.ms" --signature "q is prime"`
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
                                   q is prime                                   




```
