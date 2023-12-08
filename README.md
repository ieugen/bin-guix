# binary-guix

Binary packages for guix.
This is a guix channel that aims to package binary releases of popular applications to make them available in guix.

People should use native guix packages (packages that are built from sources) whenever they get the chance.
But let's face it, it's not always possible.
For situations when your favorite app is not packages for guix and has linux binary release, bin-guix channel should provide an escape hatch.

## Why binary apps

I do a lot of devops tinkering and I need specific tools that are not available (or up to date) from Guix or the GNU/Linux distribution of choice (Debian in my case).

This led me to use a bunch of tooling to fix this.
Some of the tooling I use/used for package installation is in the list bellow: 
- distribution native package manager: apt / apt-get
- nvm - node version manager to install node.js releases
- sdkman.io - version manager to install specific java / jdk releases
- flatpak - for gui apps
- snaps - I prefer flatpak but sometimes there is no choice
- docker containers - mostly for services but also for some cli apps 
- manual installation scripts

NOTE: Most packaged apps are (should be) statically linked to work without issues. This is the case with most apps available as a single binary.

 I faced issues when working with other people of setting up new computers or servers.
 It's a lot of work to keep every system with all the required tools installed and up to date.
 
 This is especially true when working in a team and you have many developers. 
 
 It would be nice to have a single tool that can produce the environment that people can use to get their job done.
 
 I believe that Guix is a tool that can be used for such a thing.
 

## How to use this channel

- Add bin-guix channel to your list of channels
- Run `guix pull`
- Install packages

On Debian, my channels configuration file is in `$HOME/.config/guix/channels.scm`
It might be different on your distribution.
When in doubt see https://guix.gnu.org/manual/en/html_node/Specifying-Additional-Channels.html 

I believe the order is important and since bin-guix is before `%default-channels` packages 
will be pulled from bin-guix first if they have the same name.

```scheme
(cons* 
       ;;  My other channels here
       (channel
        (name 'bin-guix)
        (url "https://github.com/ieugen/bin-guix")
        (branch "main")
        ;;Enable signature verification:
        ;;TBA
        )
       %default-channels)
```


## Development

You can add new packages as `*.scm` (scheme) files under `bin-guix/packages`. 
See the definitions for the other packags as examples.

Before we begin the package, download a release and get the hash:

``` shell
# Use `guix download` to fetch file and compute hash
guix download  https://github.com/oras-project/oras/releases/download/v0.16.0/oras_0.16.0_linux_amd64.tar.gz  --hash=sha256

```

Then you can create your `bin-guix/packages/<name>.scm` module that contains the package definition.
Once you added a new package, test it works locally then commit and push.

``` shell
# Build a package from definition, keeping directory if build fails
guix build -L . -K babashka

# Force rebuild a package
guix build --check --no-grafts babashka

# To "clean" remove the package from guix run:
guix gc -D <STORE-PATH>

```

https://www.alexandrostheodotou.com/guix-packagers-guide.html
