require "formula"

class Shtools < Formula
  homepage "https://shtools.ipgp.fr"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v3.2.tar.gz"
  sha256 "f9c6c4b14ad26204d3f727d53195fe945bd45744eae52db71229adef511d31e2"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "gcc"
  depends_on "fftw"  => ["with-fortran"]
  
  def install

    ENV.prepend_path "PATH", "/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin"
    system "make"

    (share/"shtools").install "examples"
    inreplace share/"shtools/examples/fortran/Makefile", "../../lib", "/usr/local/lib"
    inreplace share/"shtools/examples/fortran/Makefile", "../../modules", "/usr/local/include/shtools"
    inreplace share/"shtools/examples/Makefile", "../../lib", "/usr/local/lib"
    inreplace share/"shtools/examples/Makefile", "../../modules", "/usr/local/include/shtools"
    (doc).install "index.html"
    (doc).install "www"
    (prefix/lib).install "lib/libSHTOOLS.a"
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
            import pyshtools as shtools

        To run the test/example suite:

            make -C /usr/local/share/shtools/examples/ fortran-tests
            make -C /usr/local/share/shtools/examples/ python-tests

        Local SHTOOLS web documentation:

            /usr/local/share/doc/shtools/index.html

        To obtain information about the SHTOOLS brew installation, enter

            brew info shtools
    EOS
    s
  end

end

