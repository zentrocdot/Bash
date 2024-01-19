# README

<pre>Read the below sections 'Prerequisites' and 'Warning' first before you are using the transparent proxy.</pre>

## General informations

### Introduction

<p align="justify">There are various ways to anonymize the Internet traffic. One way is using a tool called <code>proxychains</code> another way is using <code>Tor</code>. For <code>proxychains</code> one needs a list of proxy servers of type socks5, socks4, https and http.</p>

### Motivation

<p align="justify">I tried <code>proxychains</code> with several proxy servers in parallel to <code>Tor</code>. The use of both approaches was unsatisfactory for me. So I decided to use an different approach.</p>

### Objective

<p align="justify">The aim should be to anonymise all Internet traffic via an interface without having to worry about whether a program is running or not in the background. TCP/IP traffic as well as DNS requests should be tunneled over the approach.</p>

### Approach

<p align="justify">The chosen approach is a transparent proxy that tunnels any type of Internet traffic locally over the defined interface. It should also be possible to control the transparent proxy via a GUI. In the end, I implemented this as Bash script.</p>

### Security Check

<p align="justify">For certain groups of people, their lives may depend on Internet traffic not having leaks that jeopardize their anonymity. I wrote the script <code>anonymity_check.bash</code> to check, if everything works the right way. The results of the performed tests can be independently checked against other sources.</p>

## Script trans_proxy.bash

<p align="justify">The transparent proxy is designed to work with ipv4. Keeping this in mind, I disabled ipv6 permanently. This prevents me from having a data leak via ipv6.</p>

## Script anonymity_check.bash

### Remarks

<p align="justify">The script performs the following tests:</p>

1. Check if Tor is runninng on boot
2. Check if DNS over Tor is working
3. Check if DNS in general is working
4. Check if the Tor exit node is valid
5. Check the geolocation data related to the IP address

<p align="justify">At the end of the tests, the script reports whether the tests have all been passed or not.</p>

### Prerequisites

<p align="justify">Installation of <code>resolvconf</code> and <code>xdotool</code> is required.</p>

<pre>sudo apt-get install resolvconf
sudo apt-get install xdotool</pre>

### Customisation Trans Proxy

<p align="justify">Change the variable _OUT_IF="wlan0" to your personal needs. That's all you have to do to get the trans proxy running.</p>

### Warning

<p align="justify">It is recommended to make a copy of <code>resolv.conf</code>. If <code>resolvconf</code> is not installed, DNS requests will fail in the future. In the year 2018, when I wrote the transparent proxy, <code>resolvconf</code> was still installed by default.</p>

## General note

<p align="justify">The presented scripts are produced independently from the Tor® anonymity software and carries no guarantee from The Tor Project about quality, suitability or anything else.</p>


