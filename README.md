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

 I faced issues when working with other people of setting up new computers or servers.
 It's a lot of work to keep every system with all the required tools installed and up to date.
 
 This is especially true when working in a team and you have many developers. 
 
 It would be nice to have a single tool that can produce the environment that people can use to get their job done.
 
 I believe that Guix is a tool that can be used for such a thing.
 
 
## Development

You can add new packages as `*.scm` (scheme) files under `bin-guix/packages`. 
See the definitions for the other packags as examples.

Once you added a new package, test it works locally then commit and push.


``` shell
# Build a package from definition, keeping directory if build fails
guix build -L . -K babashka

# Force rebuild a package
guix build --check --no-grafts babashka

```

https://www.alexandrostheodotou.com/guix-packagers-guide.html
