class Shtools < Formula
  desc "Spherical Harmonic Tools"
  homepage "https://shtools.github.io/SHTOOLS/"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v4.7.1.tar.gz"
  sha256 "6ed2130eed7b741df3b19052b29b3324601403581c7b9afb015e0370e299a2bd"
  license "BSD-3-Clause"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  option "with-openmp", "Install the Fortran 95 OpenMP components of SHTOOLS"
  option "with-examples", "Install the Fortran 95 example code and data"

  depends_on "fftw"
  depends_on "gcc"

  def install
    system "make", "fortran"
    system "make", "fortran-mp" if build.with?("openmp")

    if build.with?("examples")
      pkgshare.install "examples/fortran/"
      pkgshare.install "examples/ExampleDataFiles/"
    end

    lib.install "lib/libSHTOOLS.a"
    lib.install "lib/libSHTOOLS-mp.a" if build.with?("openmp")
    include.install "include/fftw3.mod", "include/planetsconstants.mod", "include/shtools.mod", "include/ftypes.mod"
    share.install "man"
  end

  def caveats
    <<~EOS
      ***************************************************************************
      *
      *    The homebrew tap that you are using to install SHTOOLS will no longer
      *    be supported after version 4.8. To install the official version of
      *    SHTOOLS, please do the following:
      *
      *      brew uninstall shtools
      *      brew untap shtools/shtools
      *      brew install shtools
      *
      ***************************************************************************
      To use SHTOOLS with your gfortran code, compile with the options
        -I/usr/local/include -lSHTOOLS -lfftw3 -lm -framework accelerate -m64 -O3
      Location of the example code and data:
        /usr/local/share/shtools
      To run the test suite (must install with the option --with-examples):
        brew test shtools
    EOS
  end

  test do
    cp_r pkgshare, testpath
    system "make", "-C", "shtools/fortran",
                   "run-fortran-tests-no-timing",
                   "F95=gfortran",
                   "F95FLAGS=-m64 -fPIC -O3 -std=gnu -ffast-math",
                   "MODFLAG=-I/usr/local/include",
                   "LIBPATH=/usr/local/lib",
                   "LIBNAME=SHTOOLS",
                   "FFTW=-L /usr/local/lib -lfftw3 -lm",
                   "LAPACK=-framework accelerate",
                   "BLAS="
  end
end
