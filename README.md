SHTOOLS homebrew tap
--------------------

This repo is the SHTOOLS homebrew tap, which can be used to install SHTOOLS on OSX.


Installation instructions
-------------------------

If brew is not already installed, install it using the following command in the terminal window:

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

If brew is already installed, update it and the previously installed packages using

    brew update
    brew upgrade
 
To download and install the SHTOOLS tap, enter

    brew tap shtools/shtools
    brew install shtools

To run the examples and tests, enter

    make -C /usr/local/share/shtools/examples/ fortran-tests
    make -C /usr/local/share/shtools/examples/ python-tests
To obtain information about the brew installation of SHTOOLS, enter

    brew info shtools

For more information
--------------------
SHTOOLS web site: [shtools.ipgp.fr](http://shtools.ipgp.fr)<br>
SHTOOLS at GitHub: [SHTOOLS/SHTOOLS](https://github.com/SHTOOLS/SHTOOLS)<br>
SHTOOLS wiki: [Wiki](https://github.com/SHTOOLS/SHTOOLS/wiki)<br>
SHTOOLS Twitter developer feed: [Twitter](https://twitter.com/SH_tools)
