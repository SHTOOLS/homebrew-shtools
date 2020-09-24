class Shtools < Formula
  desc "Spherical Harmonic Tools"
  homepage "https://shtools.github.io/SHTOOLS/"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v4.7.1.tar.gz"
  sha256 "176610743ddd76ea1fe7b45db3e8613171630b85c3759c9a4b31cde6b5d2ae3d"
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
