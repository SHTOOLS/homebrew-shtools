class Shtools < Formula
  desc "Tools for working with spherical harmonics"
  homepage "https://shtools.github.io/SHTOOLS/"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v4.5.4.tar.gz"
  sha256 "cad0d2e1ca72f3d423a49d98145b0ad4892d1d2cba3ad5851e0faad537cb30f8"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  option "with-openmp", "Install the Fortran 95 OpenMP components of SHTOOLS"

  depends_on "gcc"
  depends_on "fftw"

  def install
    system "make", "fortran"

    if build.with? "openmp"
      system "make", "fortran-mp"
    end

    pkgshare.install "examples"
    inreplace pkgshare/"examples/fortran/Makefile", "../../lib", "/usr/local/lib"
    inreplace pkgshare/"examples/fortran/Makefile", "../../modules", "/usr/local/include"
    lib.install "lib/libSHTOOLS.a"
    include.install "modules/fftw3.mod", "modules/planetsconstants.mod", "modules/shtools.mod", "modules/ftypes.mod"
    share.install "man"

    if build.with? "openmp"
      lib.install "lib/libSHTOOLS-mp.a"
    end
  end

  def caveats
    s = <<~EOS
        To use SHTOOLS with gfortran, compile with
            gfortran -I/usr/local/include -m64 -fPIC -O3 -lSHTOOLS -lfftw3 -lm -framework accelerate
        To run the test/example suite:
            make -C /usr/local/share/shtools/examples/fortran/ LAPACK="-framework accelerate" BLAS="" run-fortran-tests
        To obtain information about the SHTOOLS brew installation, enter
            brew info shtools
    EOS
    s
  end
end
