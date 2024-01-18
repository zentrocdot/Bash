# README

> <p align="justify">Read section Prerequisites and Warning first before using the transparent proxy.</p>

> <p align="justify">There are various ways to anonymize the Internet traffic. One way is using a tool called <code>proxychains</code> another way is using <code>Tor</code>. For <code>proxychains</code> one needs a list of proxy servers of type socks5, socks4, https and http.</p>

### Motivation

> <p align="justify">I tried <code>proxychains</code> with several proxy servers in parallel to <code>Tor</code>. The use of both approaches was unsatisfactory for me. So I decided to use an different approach.</p>

### Objective

> <p align="justify">The aim should be to anonymise all Internet traffic via an interface without having to worry about whether a program is running or not in the background. TCP/IP traffic as well as DNS requests should be tunneled over the approach.</p>

### Approach

> <p align="justify">The chosen approach is a transparent proxy that tunnels any type of Internet traffic locally over the defined interface. It should also be possible to control the transparent proxy via a GUI. In the end, I implemented this as Bash script.</p>

### Security Check

> <p align="justify">For certain groups of people, their lives may depend on Internet traffic not having leaks that jeopardize their anonymity. I wrote the script <code>anonymity_check.bash</code> to check, if everything works the right way. The results of the performed tests can be independently checked against other sources.</p>

### Customisation Trans Proxy

Change the variable _OUT_IF="wlan0" to your personal needs. That's all you have to do to get the trans proxy running.

### Prerequisites

Installation of <code>resolvconf</code> and <code>xdotool</code> is needed.

### Warning

Make a copy of resolv.conf. If resolvconf is not installed, DNS requests will fail.

### Notice

> <p align="justify">The presented scripts are produced independently from the Tor® anonymity software and carries no guarantee from The Tor Project about quality, suitability or anything else.</p>


