class Shtools < Formula
  desc "Tools for working with spherical harmonics"
  homepage "https://shtools.ipgp.fr"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v3.3.tar.gz"
  sha256 "8b28b79d8975bc0dfa3d9ca731240557009f98a7d1b611c74ba4573791efe145"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  option "with-python2", "Install the Python 2 components of SHTOOLS"
  option "with-python3", "Install the Python 3 components of SHTOOLS"
  option "with-openmp", "Install the Fortran 95 OpenMP components of SHTOOLS"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "gcc"
  depends_on "fftw"  => ["with-fortran"]

  if build.with? "python3"
    depends_on :python3
  end

  def install
    system "make", "fortran"

    if build.with? "python2"
      system "make", "python2", "F2PY=/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin/f2py"
    end
    if build.with? "python3"
      system "make", "python3", "F2PY3=python3 -m numpy.f2py"
    end
    if (build.with? "python2") && (build.with? "python3")
      cp_r("pyshtools", "pyshtools3")
    end
    if build.with? "openmp"
      system "make", "fortran-mp"
    end

    pkgshare.install "examples"
    inreplace pkgshare/"examples/fortran/Makefile", "../../lib", "/usr/local/lib"
    inreplace pkgshare/"examples/fortran/Makefile", "../../modules", "/usr/local/include"
    doc.install "index.html"
    doc.install "www"
    lib.install "lib/libSHTOOLS.a"
    include.install "modules/fftw3.mod", "modules/planetsconstants.mod", "modules/shtools.mod"
    share.install "man"

    if (build.with? "python2") && (build.with? "python3")
      (lib/"python2.7/site-packages").install "pyshtools"
      mv("pyshtools3", "pyshtools")
      (lib/"python3.5/site-packages").install "pyshtools"
    elsif build.with? "python2"
      (lib/"python2.7/site-packages").install "pyshtools"
    elsif build.with? "python3"
      (lib/"python3.5/site-packages").install "pyshtools"
    end
    if build.with? "openmp"
      lib.install "lib/libSHTOOLS-mp.a"
    end
  end

  def caveats
    s = <<-EOS.undent
        To use SHTOOLS with gfortran, compile with

            gfortran -I/usr/local/include -m64 -fPIC -O3 -lSHTOOLS -lfftw3 -lm -llapack -lblas

        To use SHTOOLS in Python 2:

            import sys
            sys.path.append('/usr/local/lib/python2.7/site-packages')
            import pyshtools

        To use SHTOOLS in Python 3:

            import sys
            sys.path.append('/usr/local/lib/python3.5/site-packages')
            import pyshtools

        To run the test/example suite:

            make -C /usr/local/share/shtools/examples/ fortran-tests
            make -C /usr/local/share/shtools/examples/ python2-tests
            make -C /usr/local/share/shtools/examples/ python3-tests

        Local SHTOOLS web documentation:

            /usr/local/share/doc/shtools/index.html

        To obtain information about the SHTOOLS brew installation, enter

            brew info shtools
    EOS
    s
  end
end
