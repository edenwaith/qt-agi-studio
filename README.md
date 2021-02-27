QT AGI Studio, release 1.3.2

About
=====

AGI (Adventure Game Interpreter) is the adventure game engine used by
Sierra On-Line&trade; to create some of their early games. QT AGI Studio
(formerly known as Linux AGI Studio) is a program which allows you to
view, create and edit AGI games. Basically, it is an enhanced port of
the Windows AGI Studio developed by Peter Kelly.

The program contains very little platform specific code so brave ones
are encouraged to try it on other operating systems that have QT
library support.


Availability
============

QT AGI Studio is available at [http://agistudio.sourceforge.net/](http://agistudio.sourceforge.net/)   
The Macintosh version of QT AGI Studio is available at [https://github.com/edenwaith/qt-agi-studio](https://github.com/edenwaith/qt-agi-studio)  
The project is licensed under the GPL, GNU General Public License.
See COPYING for details.


System requirements
===================

Linux:  GNU make, g++, X Window System, QT library  
Macintosh: Xcode, Qt Creator, QT library  

The program is now being developed with QT version 4.

NAGI, Sarien or ScummVM AGI interpreter is recommended to run games.
Sarien is available at http://sarien.sourceforge.net/
and NAGI at http://www.agidev.com/nagi.html
Sarien is more focused on portability and NAGI on compatibility
with Sierra's original AGI interpreter. Both are free.
ScummVM is actively developed, but does not integrate well
with QT AGI studio.

WINDOWS NOTE: the code hasn't been tested on Windows lately.
If you are interested, please go ahead, make a working
Visual Studio project and send a patch!


Building
========

Run "make" in the src subdirectory. If the supplied Makefile doesn't work,
you can either fix it or use `tmake` to generate a makefile for your platform:

` qmake agistudio.pro -o Makefile`

If you don't have `tmake`, you can download it at http://www.trolltech.com

Make assumes that QT4 is installed and working (in particular, the `QTDIR`
environment variable is properly set)

**Troubleshooting**

Install missing *qmake*

`sudo apt-get install qt4-qmake`

Project ERROR: Unknown module(s) in QT: qt3support

 It needs to be qt3support. You may need to use qmake-qt4 explicitly:

`qmake-qt4 "QT += qt3support" agistudio.pro -o Makefile`


Installation and setup
======================

The binary is called agistudio and will be built in the src subdirectory; you
can copy it to any path convenient to use (e.g. `/usr/local/bin`). In order to
use the help and an example game template, copy them to any convenient place
and specify the appropriate paths in the "Settings" menu when you'll run
agistudio.

For the Macintosh version, place the AGI Studio.app into the Applications folder.

AGI studio has its own help viewer, but you can also view the help with
any HTML browser.

If agistudio complains that it can't load qt shared library, then set the
`LD_LIBRARY_PATH` environment variable to the path which contains `libqt.so.*`.

Using
=====

Please read the online help. Note that if you want to use existing games'
files, all the filenames must be in lower case.


Credits
=======

 * Helen Zommer <helen@cc.huji.ac.il> - primary development
 * Jarno Elonen <elonen@iki.fi> - bitmap import, current maintainer

 * Chris Cromer <chris@cromer.cl> - fix build for gcc 7 with 64bit
 * Nat Budin <natb@brandeis.edu> - Win32 port
 * Chad Armstrong <chad@edenwaith.com> - Macintosh port
 * Claudio Matsuoka <claudio@helllabs.org> - sound support
 * Peter Kelly <pmk@post.com> - the original Windows version
 * Lance Ewing <lance.e@ihug.co.nz> - the original (DOS) Picedit


Feedback
========

Please visit project website at http://agistudio.sourceforge.net/ to
submit bug reports, comments, suggestions, etc.

Hope you'll have as much fun using it as we've had developing it :-)
