This is a conversion to Windows 9x/NT/2K of SSLftp-0.13, upgraded to compliance
with RFC2228 "FTP Security Extensions" and "Securing FTP with TLS" Internet
draft. This file accompanies the binary distribution of TLS/SSL-aware FTP
client.

Ftps implements a BSD-style FTP client with TLS/SSL support. It provides enough
functionality as standard FTP client too, so it can be recommended as
replacement for standard console ftp utility shipped with Windows.

This implementation has the basic command line prompt, use ? to get a list of
supported commands. Full description of command-line options and built-in
commands are available in ftps.1.html file. Another documentation is located in
docs subdirectory.

The TLS/SSL encryption can be used with BSDftpd-ssl (http://bsdftpd-ssl.sc.ru)
or SSLftp versions of the TLS/SSL-aware FTP daemons. With standard FTP server
this software operates as standard FTP client.

Ftps uses OpenSSL 0.9.6 (or higher) dynamic loadable libraries (libeay32.dll
and ssleay32.dll), which may be obtained separately from
http://bsdftpd-ssl.sc.ru/download.html.

To install, unzip archives and place the exe and dlls to the same directory.
To run, simply execute ftps in that directory.

Please let me know if you find any problems with this software.

The code was adapted from the unix version of SSLftp-0.13, written by
Tim Hudson (tjh@cryptsoft.com), and similar adaptation of SSLftp-0.8, made by
Jon Thornber (jon@tilebarn.demon.co.uk). The original code can be found at
http://www.psy.uq.oz.au/~ftp/Crypto/.

--
    Nick Leuta
    URL: http://bsdftpd-ssl.sc.ru
    Email: skynick@stu.lipetsk.ru
