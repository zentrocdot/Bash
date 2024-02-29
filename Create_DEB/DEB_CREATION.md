# DEB CREATION

<p align="justify">Following my personal needs in software development I am writing down how to get to a working skeleton for Debian DEB packages. Remember that Linux Mint
as well as Linux Ubuntu are derivates of Linux Debian.</p>

<p align="justify">The name of the DEB package should be in long form <code><PackageName>_<VersionNumber>-<DebianRevisionNumber>_<DebianArchitecture>.deb</code> and 
<code><PackageName>_<VersionNumber>_<DebianArchitecture>.deb</code> in short form [1]. Last one is the one I need.</p>

<p align="justify">First I create a folder for the DEB package creation.</p>

    mkdir USR_DEB

<p align="justify">Change into the new created directory.</p>

    cd USR_DEB

<p align="justify">Create the package directory following the naming rule required by dh_make.</p>

    mkdir helloworld-0.0.0.1-all

<p align="justify">Run dh_make.</p>

    dh_make -y --indep --createorig

<p align="justify">See arguments of dh_make.</p>

     dh_make -h

<p align="justify">Using dh_make results in a skeleton for the package.</p>

<p align="justify">Create following file in the folder.</p>

    #!/usr/bin/bash
    printf "%s%b" "Hello World!" "\n"
    exit 0

<p align="justify">Run dh_make again.</p>

     dh_make -y --indep --createorig

<p align="justify">Create in debian the file install with following content.</p>

    helloworld usr/bin

<p align="justify">run following command.</p>

    debuild --no-lintian -us -uc -D

<p align="justify">Install the DEB file.</p>

    helloworld_0.0.0.1-all-1_all.deb

<p align="justify">Now try on the command line.</p>

    ~$ helloworld
    ~$ Hello World!

<p align="justify">This is the base procedure behind my script for creating a deb package.</p>

# To-do:

<p align="justify">Check the described procedure on problems or errors.</p>

# Reference

[1] www&#8203;.debian.org/doc/manuals/debian-faq/pkg-basics.en.html

