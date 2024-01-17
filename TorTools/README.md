# README.md

### Introduction

< <p align="justify">Internet traffic consists of two parts. First this is TCP/IP and second it is DNS. When Tor is working, then the Tor network sends data and is masking this traffic. This is done using the well known IP-adresses. Nevertheless on needs DNS for translating web adresses to IP and vice versa. This means one has to take care that both traffic runs over Tor. It could be that something is leaked and on is uncovered. And it is not easy to find out which could be the problem. So I wrote an easy to use script, wwhich checks if everything is all right.</p>

### Tor Check

< <p align="justify">The script is checking if TCP/IP as well as DNS is using Tor. In addition to this the script checks if the exit node is a valid exit node of Tor.</p>
