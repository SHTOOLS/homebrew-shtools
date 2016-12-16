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
 
To download and install the SHTOOLS tap that contains the Fortran 95 components, enter

    brew tap shtools/shtools
    brew install shtools

To install the Fortran 95 OpenMP component, add `--with-openmp` to the last command

    brew install shtools --with-openmp
    
The Python2 and Python 3 components can also be built (using the Makefile) by adding `--with-python2`  and `--with-python3`. Nevertheless, it is recommended to instead install these components using the Python package manager `pip`:

    pip install pyshtools  # for Python 2
    pip3 install pyshtools # for Python 3

To use SHTOOLS in Python 2:

    import sys
    sys.path.append('/usr/local/lib/python2.7/site-packages')
    import pyshtools

To use SHTOOLS in Python 3:

    import sys
    sys.path.append('/usr/local/lib/python3.5/site-packages')
    import pyshtools

To run the examples and tests, enter

    make -C /usr/local/share/shtools/examples/ fortran-tests
    make -C /usr/local/share/shtools/examples/ python2-tests
    make -C /usr/local/share/shtools/examples/ python3-tests

The local SHTOOLS web documentation is found here:

    /usr/local/share/doc/shtools/index.html

To obtain information about the brew installation, enter

    brew info shtools

For more information
--------------------
SHTOOLS web site: [shtools.oca.eu](http://shtools.oca.eu)<br>
SHTOOLS at GitHub: [SHTOOLS/SHTOOLS](https://github.com/SHTOOLS/SHTOOLS)<br>
SHTOOLS wiki: [Wiki](https://github.com/SHTOOLS/SHTOOLS/wiki)<br>
