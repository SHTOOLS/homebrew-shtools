SHTOOLS homebrew tap
--------------------

This repo is the SHTOOLS homebrew tap, which can be used to install the Fortran 95 components of SHTOOLS on OSX.


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

To install the Fortran 95 OpenMP component, add `--with-openmp` to the last command

    brew install shtools --with-openmp

To run the examples and tests, enter

    make -C /usr/local/share/shtools/examples/ fortran-tests

The local SHTOOLS web documentation is found here:

    /usr/local/share/doc/shtools/index.html

To obtain information about the brew installation, enter

    brew info shtools

For more information
--------------------
SHTOOLS web site: [shtools.oca.eu/shtools/](https://shtools.oca.eu/shtools/)<br>
SHTOOLS at GitHub: [SHTOOLS/SHTOOLS](https://github.com/SHTOOLS/SHTOOLS)<br>
SHTOOLS wiki: [Wiki](https://github.com/SHTOOLS/SHTOOLS/wiki)<br>
