require "formula"

class Shtools < Formula
  homepage "https://shtools.ipgp.fr"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v3.0.tar.gz" 
  version "3.0"
  sha256 "e97ee5262a021c7ffe99535b3dd6a35ccc3d92b962b2f1f483969dbd0e5035f8"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"
  
  keg_only ""

  depends_on "gcc"
  depends_on "fftw"  => ["with-fortran"]

  def install

	ENV.prepend_path "PATH", "/usr/bin"
    ENV.prepend_path "PATH", "/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin"
	system "make"
	system "make python"
	(prefix).install "examples", "index.html", "lib", "Makefile", "man", "modules", "pyshtools", "src", "www", "VERSION"
    
  end

  def caveats
    s = <<-EOS.undent        
      The location of SHTOOLS is: #{prefix}
      
      To use SHTOOLS with gfortran, compile with
      
          gfortran #{prefix}/modules -m64 -fPIC -O3 -L#{prefix}/lib -lSHTOOLS -lfftw3 -lm -llapack -lblas
      
      To use SHTOOLS with python:
      
          Add #{prefix} to the system PYTHONPATH
          In python: import pyshtools as shtools
      
      To run test/example suite:
      
          cd #{prefix}
          make fortran-tests
          make python-tests

      To obtain information about the SHTOOLS brew installation, enter 
      
          brew info shtools
    EOS
    s
  end

  #test do
  # need to run tests...
  #end

end

__END__
