CIAU CIAU - Configuration and Installation AUtomation
=====================================================

Ciauciau is a simple set of script to automate installations of www.katello.org

What the?!

It's a very trivial "framework" written in Bash and you can leverage it
for installation of various software projects. It has simple concept of 
steps and plans, so you can schedule installations and configurations
in a simple and reusable way.

Upstream site is at http://github.com/lzap/ciauciau

Best to use with http://github.com/lzap/snap-guest

Features
--------

 * installs and configures katello
 * highly flexible

Requirements
------------

 * bash :-)
 * coreutils
 * vim (no, you don't really need it, but it's recommended :-)

Installation
------------

 * git clone git://github.com/lzap/ciauciau.git
 * echo 'PATH=$PATH:ciauciau/bin' >> ~/.bashrc
 * source ~/.bashrc

How it works
------------

Ciao Ciao contains two directories, plans and steps. Let's start with steps:

    # ls steps -1
    000-noop.sh
    001-noop.sh
    010-disable-iptables.sh
    100-aliases.sh
    300-setup-repos-manual.sh
    400-install-headpin.sh
    400-install-katello.sh
    499-listen-all.sh
    499-make-fast.sh
    500-configure-headpin.sh
    500-configure-katello.sh
    990-enable-services.sh
    990-start-goferd.sh
    990-updatedb.sh
    999-ping.sh

Steps are just small bash scripts which are composed into plans. They are 
*always* executed in order, therefore you can remove and add steps manually 
using command line options and they will be always sorted before execution.

Plans are bash scripts that sets environment variables required in these steps 
and creates a bash array called PLAN which is then executed.

    # ls plans -1
    empty
    hd
    katello-template
    kt

Plans can inherit each other, by default there are two plans: kt installs 
Katello nighty and hd installs Headpin nightly. They both inherit from 
katello-template plan and add their own steps.

Here are the options of the ciau script:

    OPTIONS:
      -h    Show this message
      -p    Plan name (see ./plans directory)
      -e    Evaluate statement before plan file (see plan file for options)
      -x    Exclude one or more steps from the plan (grep syntax)
      -i    Include extra steps to the plan (separate by space)

    EXAMPLES:

      ciau -p kt
      ciau -p kt -x '(300|301)' -i 200-my-step.sh
      ciau -p kt -e 'MIRROR=http://abc/nightly EPEL=http://xyz/pup/epel'

Example scripts - Katello
-------------------------

To install Katello systems management cloud solution (www.katello.org) just do 
this:

    ciau -p kt -e 'VERSION=1.1'

If you won't provide -e option, it will install nightly instead of the 
specified stable version.

If you need to change repositories (e.g. you have closer mirror for Katello and 
EPEL repos) setup those variables (see plans/kt for more info):

    export MIRROR=http://my.mirror.com/koji
    export EPEL=http://my.epel.mirror.com/pub/fedora/epel
    ciau -p kt

To get particular SAM installation or SE installation type:

    ciau -p sam -e 'THE_REPO="http://download/xx/yy/1.1/latest/"'
    ciau -p se -e 'THE_REPO="http://download/xx/zz/2.0/latest/"'

To install SE/SAM and then upgrade it immediately run:

    ciau -p se -e 'THE_REPO="http://download/xx/zz/2.0/latest/" THE_REPO_UPGRADE="http://xyz/2.1/latest"' -i 600-upgrade.sh

To see all available plans open the ./plans directory:

https://github.com/lzap/ciauciau/tree/master/plans

And to see particular steps (so you can skip them or create your own plans) 
see:

https://github.com/lzap/ciauciau/tree/master/steps

Use the -i option to include particular steps which are not part of the plan 
you want to use, use the -x option to "greo out" steps you do not want to do. 
And using ENV variables you can change behavior of your plans.

All steps are sorted before execution, therefore you can make sure your step is 
on the correct place (before or after other step). If you are going to add 
steps, make sure they have correct number and also unique name, so you can then 
add steps easily:

    ciau -p katello-1.1 -i "import-fake self-reg cli-tests upgrade-1.2"

I will be slowly adding more and more plans - installation of stable katello 
versions, running basic tests (manifest import, cli smoke tests), upgrade tests 
and other things I run on a daily basis.

Currently the only supported subject of interest is Katello, but if you like 
Ciau Ciau, I would be happy to add multi-project support so one can switch 
between "step suites" and plans.

Easy, huh? Patches appreciated.

Why the name
------------

Because I can!

![ciau ciau](http://images04.olx.lt/ui/2/97/15/25499215_1.jpg "Ciau Ciau")

Credits and license
-------------------

Ciau Ciau and all the scripts are distributed as public domain.

vim: tw=79:fo+=w
