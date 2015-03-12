require "formula"

class Shtools < Formula
  homepage "https://shtools.ipgp.fr"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v3.0.tar.gz" 
  version "3.0"
  sha256 "e97ee5262a021c7ffe99535b3dd6a35ccc3d92b962b2f1f483969dbd0e5035f8"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"
  
  depends_on "gcc"
  depends_on "fftw"  => ["with-fortran"]

  def install

	ENV.prepend_path "PATH", "/usr/bin"
    ENV.prepend_path "PATH", "/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin"
	system "make"
	system "make python"
	#(prefix).install "examples", "index.html", "lib", "Makefile", "man", "modules", "pyshtools", "src", "www", "VERSION"
    
    (share/"shtools").install "examples"
    (doc).install "index.html"
    (doc).install "www"
    (prefix).install "lib"
    (include).install "modules/fftw3.mod", "modules/planetsconstants.mod", "modules/shtools.mod"
    (share).install "man"
    (lib/"python2.7/site-packages").install "pyshtools"
    
  end

  def caveats
    s = <<-EOS.undent        
        To use SHTOOLS with gfortran, compile with
      
            gfortran -I/usr/local/include -m64 -fPIC -O3 -lSHTOOLS -lfftw3 -lm -llapack -lblas
      
        To use SHTOOLS in Python:
      
            import sys
            sys.path.append('/usr/local/lib/python2.7/site-packages')
            (alternatively, add /usr/local/lib/python2.7/site-packages to the system PYTHONPATH)
            import pyshtools as shtools
      
        To run the test/example suite:  
           
            cd /usr/local/share/shtools/examples/fortran
            make fortran-tests (NOTE: the Makefile needs to be updated to use -I/usr/local/include)
            cd /usr/local/share/shtools/examples/fortran
            make python-tests
                 
        Local SHTOOLS web documentation:
      
            /usr/local/share/doc/shtools/index.html

        To obtain information about the SHTOOLS brew installation, enter 
      
        brew info shtools
    EOS
    s
  end

end

__END__
