class Shtools < Formula
  desc "Tools for working with spherical harmonics"
  homepage "https://shtools.oca.eu"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v4.1.tar.gz"
  sha256 "79dd911f3482a7e577b4e0d23b1f141eff90cb3dccfe518f1968c02cdfca5448"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  option "with-openmp", "Install the Fortran 95 OpenMP components of SHTOOLS"

  depends_on "gcc"
  depends_on "fftw"  => ["with-fortran"]

  def install
    system "make", "fortran"

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

    if build.with? "openmp"
      lib.install "lib/libSHTOOLS-mp.a"
    end
  end

  def caveats
    s = <<-EOS.undent
        To use SHTOOLS with gfortran, compile with

            gfortran -I/usr/local/include -m64 -fPIC -O3 -lSHTOOLS -lfftw3 -lm -llapack -lblas

        To run the test/example suite:

            make -C /usr/local/share/shtools/examples/ fortran-tests

        Local SHTOOLS web documentation:

            /usr/local/share/doc/shtools/index.html

        To obtain information about the SHTOOLS brew installation, enter

            brew info shtools
    EOS
    s
  end
end
