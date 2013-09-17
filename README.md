
# Antikc -- hp93k Software From This Century

Want __Git__ and a modern __Python__ and __Perl__ on your old-ass hp93000
RHEL3/5 workstation? Want to participate in the magical world of Open Source?
But unfortunately you're a semiconductor test engineer?  Read on.

## For the Brave and Lazy

Brave and lazy, huh? Just download this script:
[antikc-for-the-brave-and-lazy.sh](https://github.com/gitfoxi/antikc/raw/master/bootstrap/extra/antikc-for-the-brave-and-lazy.sh)

Then run:

    bash antikc-for-the-brave-and-lazy.sh
    
If everything went well. Antikc is installed and the environment is set up in
your current terminal. To get it in all terminals, log out and log back in.

Read on to learn more and install in an un-crazy, tutorial fashion.

## The hp93k Curse

You're hacking on the hp93k -- perhaps on old HP c400 from the 90s, or maybe a
shiny new Advantest SmartScale delivered yesterday -- and you're sad. The
platform is Linux which you like but it's as if the world stopped turning in
1999.

* Redhat Enterprise Linux 3 -- released 2003, end of life 2006
* Redhat Enterprise Linux 5 -- released 2007, end of life 2013

Antikc is here to help. Antikc bootstraps 2013 versions of critical development
tools like __Git__ and __Python__.

Antikc provides a modern base and an umbrella project for hp93k open-source
software development.


## Antikc installs software in your `/home` directory

You're working at a public lab or on a restrictive corporate network. You don't
have root on your machine, which is what you'd need to upgrade it in the
traditional way. Anyhow, SmarTest is held together with so much duct tape and
spit that if you were to upgrade underlying system libraries it would certainly
fail.

Antick is meant to install under `/home/user/antikc`. This way you're free to
upgrade the parts of your environment that need upgrading and leave the rest
untouched. No root required.


## SmarTest is still 32-bit -- Antikc is too

SmarTest remains 32-bit even in version 7 under a 64-bit kernel. If you want to
link with the command set interface or testmethods all of your libraries need
to be 32-bit. For the time being Antikc builds all software 32-bit.

In the future, Antikc may build 64-bit programs too. For now, only 32-bit makes
sense.

__IMPORTANT: If you are logging on to multiple workstations, mixed RHEL3 and
RHEL5, build Antikc on an RHEL3 workstation and everything will work fine on
RHEL5. Don't build on RHEL5 unless that is all you use.__


## Bootstrapping

Start in your home directory:

    cd ~

You don't have git installed but Antikc comes from github so open your web browser and go to
[https://github.com/gitfoxi/antikc](https://github.com/gitfoxi/antikc)
and click the
[Download ZIP](https://github.com/gitfoxi/antikc/archive/master.zip)
button. Alternatively you can do it on the command-line:

    wget --no-check-certificate https://github.com/gitfoxi/antikc/archive/master.zip

The `--no-check-certificate` was required on my system to download from https,
I'm assuming because of old-ass Redhat's broken SSL.

Unzip it:

    unzip master
    rm master
    mv antikc-master antikc
    cd antikc

To begin the build process:

    cd bootstrap
    ./makeall

Now you have shiny-new `git`, `python` and other utilities. Put them in your
path by adding this to the end of your `~/.profile` or `~/.bash_profile`:

    export PATH=$HOME/antikc/32bit/bin:$PATH
    export MANPATH=$HOME/antikc/32bit/share/man:/usr/share/man:/usr/local/share/man:/usr/X11R6/man

Log out and log back in, or to fix it in the current shell only:

    source ~/.profile

If you're a csh/tcsh/ksh fan, edit your `~/.cshrc` or `~/.tcshrc`:

    setenv PATH $HOME/antikc/32bit/bin:$PATH
    setenv MANPATH $HOME/antikc/32bit/share/man:/usr/share/man:/usr/local/share/man:/usr/X11R6/man

And give it a:

    source ~/.cshrc

Now you should be able to type:

    git

And see a list of `git` commands.

To use your new python:

    python2.7

To install packages into your new python you have:

    pip-2.7

But I really recommend developing in a virtualenv. There's
[pleanty of tutorials on virtualenv](http://iamzed.com/2009/05/07/a-primer-on-virtualenv/).
But the basic run through is:

    virtualenv --no-site-packages mycoolproject
    cd mycoolproject
    source bin/activate
    pip install mycooldependency

Now that we have git installed, let's turn Antikc into a git repo so you can
pull updates. I'm sure it will get better and better.

    cd ~/antikc
    git init
    # If you're working with your own clone then use the URL for your account instead
    git remote add origin https://github.com/gitfoxi/antikc
    git pull --force origin master
    git reset --hard

Finally, there's a bunch of other hp93k-related projects under the Antikc
unbrella. To check out those codes, say:

    git submodule init
    git submodule update


## Updating

There should be new, even-better versions of Antikc et. all coming out often.
To get the updates:

    git pull
    git submodule update

Then to build newly-added software:

    cd ~/antikc
    ./makeall

To install new codes from the submodules ... there's no slick way to do that
yet. See specific projects for details.

## What's in Antikc?

Antikc bootstrap sets up 32-bit versions of:

* Python 2.7.5 -- with Pip and Virtualenv
* Git 1.8.4
* Perl 5.18.1

Plus a few dependencies to make those work.


## What can I do with Antikc?

Anything you want. I suggest:

* Use Git to version-control your device directories and other projects
* Use Python to develop test methods
* Use Python or Perl to automate your processes
* Use pip and cpan to access a world of awesome open-source code
* Open-source your scripts and testmethods and put them on [Github](http://www.github.com).
* Organize your python projects with Virtualenv

Other ideas? Let me know!


## How Does Antikc Work?

Linux is nice to normal (non-root) users in that it allows them to build and
install software in their own directories.

Not-so nice is that you actually do have to build the software. You can't
generally, like in Windows, just download a binary and expect it to run. This
is because built-software contains references to libraries and other programs
with the full path of where they are located and that full path will differ
from home directory to home directory.

### Ways to do the same thing

There's many interesting projects to help you through the complexities of
building software and dependencies. Some that I really like are:

* [pkgsrc](http://www.pkgsrc.org/)
* [Nix](http://nixos.org/)
* Build by hand: `./configure; make; make install`

Pkgsrc includes a massive repository of build scripts. It works pretty well. My
only objection -- asside from it's super-massive and I just want a few things
-- is that it will try to build all dependencies, all the way back to
fundamental system libraries like libc and build tools like gcc. This takes
forever and eats up a lot of disk space and if something goes wrong you will
find yourself debugging deep inside some code you never heard of. Before you
can get it going, pkgsrc requires you to install cmake which is a big pain to
build under an old build system, though they do provide some scripts to help
you out.

Nix is something that has to be seen to be believed. It is a package management
system that allows multiple users to build multiple versions of all packages
and dependencies cooperitively. It links each package to its own dependencies
and lets you build a system full of software requiring different versions of
the same library. Then you can set up distribution servers to pass the packages
around to other machines. NixOS is a Linux distribution based on this package
manager. I really believe in Nix and I think that if Advantest is smart they
will build future workstations using it so that crusty old versions of
SmartTest can co-exist with the latest versions and tools.

However, for my purposes, Nix can't work. You really need root on a machine to
set it up properly, plus it doesn't like the ancient 2.4 kernel in RHEL3 and
has a hard time bootstrapping there. I have done it, but it's not something I
would try on a machine over at the ISE labs.

`./configure; make; make install` is a tried and true way of building software
from source. It is a fun game that I enjoy playing. I made Antikc to automate
the process because I was wasting too much time every time I moved into a new
environment, building my favorite programs. Still, if you have just one program
you'd like to use and it's dependencies aren't too hairy, it's a good way to
go.

###

Antikc is just a collection of bash scripts for downloading and building
software. If you're sick of living with an old Perl that can't even access Cpan
anymore and you're tired of building up a library of software in your home
directory, step-by-step, then Antikc can automate that for you.

Because it's bash scripts, the Antikc bootstrap is easy to hack and add on too,
while, at-the-same-time, arcane voodoo magic.


## Improving Antikc

You can add more packages to make Antikc bootstrap better. Some good ones for
development include:

* Ruby
* Lua
* Go

To learn how to build a package and it's dependencies from source, start by
looking at how the
[Linux From Scratch](http://www.linuxfromscratch.org/lfs/)
project does it. For example, say you want to add Ruby. Start by googling:

    ruby lfs

The first link takes you the
[Ruby-2.0.0 LFS page](http://www.linuxfromscratch.org/blfs/view/svn/general/ruby.html).

Here you find a link to download the source, an MD5 sum to check that you
definitely got the real one, a list of dependencies and some instructions on
how to make and install.

Now, edit the file:

    ~/antikc/bootstrap/include/ver

You will see lines like:

    python=(bin/python2.7 http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz Python-2.7.5.tgz Python-2.7.5 gzip b4f01a1d0ba0b46b05c73b2ac909b1df)

This basically says, to build python:

1. Check for the file `~/antikc/bin/python2.7`. If it's already there, no need to rebuild.
2. Download the source from http://www.python.org/ftp/python/2.7.5/Python-2.7.5.tgz 
3. If successful you will have a file Python-2.7.5.tgz
4. Check that the `md5sum` of the source package is b4f01a1d0ba0b46b05c73b2ac909b1df
5. Use gzip to decompress the source 
6. Untar into the directory build/Python-2.7.5

You can copy one of these lines and replace it with the info for Ruby you got from the LFS page:

    ruby=(bin/ruby2.0.0 ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.bz2 ruby-2.0.0-p247.tar.bz2 ruby-2.0.0-p247 bzip 60913f3eec0c4071f44df42600be2604)

Now edit the file:

    ~/antikc/bootstrap/makeall

You'll see a list of lines like:

    source $SCRIPTS_DIR/standard-build python

For anything that can simply be built with `./configure; make; make install`
you can use the standard-build script. So in this case, add a line at the end:

    source $SCRIPTS_DIR/standard-build ruby

And you're done. If the build instructions are more complicated you may have to
do some scripting. Go to:

    ~/antikc/bootstrap/scripts

And copy off one of the scripts

    cp perl ruby

Now edit your `ruby` script with references to **ruby** instead of **perl** (to
suck in the right info from the `include/ver` file) and change the build
instructions to your liking. Add your custom script to `makeall` like:

    source $SCRIPTS_DIR/ruby

And rerun makeall:

    cd ~/antikc/bootstrap
    ./makeall

## If you get stuck

You can rebuild everything with:

    cd ~/antikc/bootstrap
    REBUILD_ALL=1 ./makeall


## Contributing

You want to contribute to Antikc? Awesome. All you need is:

1. [A github account](https://github.com/signup/free)
2. Go to the [Antikc Github Repo](https://github.com/gitfoxi/antikc)
3. [Fork your own copy](https://github.com/gitfoxi/antikc/fork)
4. Clone your copy: `git clone https://github.com/youraccount/antikc
5. Push your commits: `git push -u`
6. Send me a [pull request on github](https://github.com/gitfoxi/antikc/pulls) (click New pull request)


## A bit more about virtualenv

When you add a dependency or when you go to release, you have to update the
requiremetns in the root of your project with:

    # Make sure virtualenv is active or you'll suck in every package installed on the system
    . bin/activate
    # Get a list of all your installed packages in this virtualenv and save it to the repo
    pip freeze > requirements.txt
    git add requirements.txt
    git commit -m "Update Requirements"

Then, when you go to deploy or update, use


    # Make sure virtualenv is active or you'll suck in every package installed on the system
    . bin/activate
    # Update repo if necessary
    git pull
    # Install the package dependencies
    pip install -r requirements.txt


## License

Copyright (c) 2013 Michael Fox

Distributed under the MIT License. See LICENSE for details.

## Thanks

Thanks [stackoverflow](http://stackoverflow.com/questions/12371668/django-and-virtualenv-adding-to-git-repo) for these ideas.

Thanks zajca for your
[LFS---by-bash-scripts](https://github.com/zajca/LFS---by-bash-scripts)
project which provides a starting point for the Antikc bootstrap.

