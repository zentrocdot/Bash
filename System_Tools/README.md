# README

## System Update and Upgrade

<p align="justify">A system update and a system upgrade can be done with the knowledge about a few commands.</p>

<pre>
sudo apt-get update          # Update of the package informations
sudo apt-get upgrade         # Upgrade of the installed packages
sudo apt-get dist-upgrade    # Upgrade of the operating system 
sudo apt-get full-upgrade    # Upgrade of the operating system 
</pre>

<p align="justify">The script <code>system_update.bash</code> automates the individual necessary steps. In addition to this the script cleans up the system from packages and data that are no longer required.</p> 

> [!TIP]
> <p align="justify">A helpful tool to keep the operating system and its packages up to date is <code>synaptic</code> which ships with a GUI. Another good tool for updating and upgrading the system is <code>aptitude</code> which can be used from the command line or from with its CLI.</p> 

## Software Installation

<p align="justify">I use a selection of programs that have proven themselves over the years. In addition to these programs, I keep alternative programs available.</p>

<p align="justify">After setting up a new operating system on a computer I run the script <code>software_install.bash</code> and I am ready to go on working.</p>

<p align="justify">I try to keep the packages up to date by deleting software that I no longer need or want and adding other packages or programs I need. Of course, I still have to do some work by hand.</p>

<p align="justify">The choice of software is based on my graphical and mathematical interests.</p>

> [!TIP]
> <p align="justify">I learned this morning that I have to take care, that the package <code>language-pack-gnome-de</code> is installed. Installing this package I have system-wide language support. E.g. after the installation the UI in <code>nano</code> is in the German language. It is also possible to install <code>language-pack-gnome-it</code> and <code>language-pack-gnome-fr</code> et cetera.</p>

## GIMP and G'MIC

<p align="justify">I have been using <code>GIMP</code> and the <code>G'MIC</code> plugin for years now successfully. <code>GIMP</code> itself is a really good tool and the plugin <code>G'MIC</code> produces impressive results.</p>

<p align="justify">Over the years the installation procedure changes a little bit. In addition to the installation via the system using <code>apt-get install gimp</code> <code>GIMP</code> can be installed by use of <code>flatpak</code>. This is the recommended way. Another way is to build <code>GIMP</code>  from source.</p>

<p align="justify">When you are downloading <code> GIMP</code>  for flatpak e.g. <code>org.gimp.GIMP.flatpakref</code> it is nothing else then a reference to a internet location, from where <code>GIMP</code>  can be installed. Open the file with a text editor and you will see what I mean.</p>

<p align="justify">This morning I wrote a simple script <code>install_gimp.bash</code>. This script allows me to install <code>GIMP</code> and <code>G'MIC</code> in an automatic way. Today I had also to learn a few things that I incorporated into the script.</p>

## References

[1]    https://www.gimp.org/

[2]    https://gmic.eu/

<hr width="100%" size="1">

<p align="justify">If you like what I present here, and if it helps you above, donate me a cup of coffee :coffee:. I drink a lot of coffee while programming and writing  :smiley:.</p>

<hr width="100%" size="2">

<p align="center">I loved the time when you could get also a hamburger :hamburger: for one euro!</p>

<p align="center">
<a target="_blank" href="https://www.buymeacoffee.com/zentrocdot"><img src="/IMAGES/greeen-button.png" alt="Buy Me A Coffee" height="41" width="174"></a>
</p>

<hr width="100%" size="2">

### Other ways to donate

<p align="justify">If you like what I present here, or if it helps you, or if it is useful, you are welcome to donate a small contribution or a cup of coffee. Or as you might say: Every TRON counts! Many thanks in advance! :smiley:</p>

<pre>TQamF8Q3z63sVFWiXgn2pzpWyhkQJhRtW7            (TRON)
DMh7EXf7XbibFFsqaAetdQQ77Zb5TVCXiX            (DOGE)
12JsKesep3yuDpmrcXCxXu7EQJkRaAvsc5            (BITCOIN)
0x31042e2F3AE241093e0387b41C6910B11d94f7ec    (Ethereum)</pre>
    
<hr width="100%" size="2">

<p align="center">File last modified 26/02/2024</p>
