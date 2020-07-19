class Shtools < Formula
  desc "Spherical Harmonic Tools"
  homepage "https://shtools.github.io/SHTOOLS/"
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v4.6.2.tar.gz"
  sha256 "47a3d0678e44167c302109bd97dcc7bf6a76f045462f02ea2baff55c86ba799f"
  license "BSD-3-Clause"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"

  option "with-openmp", "Install the Fortran 95 OpenMP components of SHTOOLS"
  option "with-examples", "Install the Fortran 95 example code and data"

  depends_on "fftw"
  depends_on "gcc"

  def install
    ENV.deparallelize
    system "make", "fortran"
    system "make", "fortran-mp" if build.with?("openmp")

    if build.with?("examples")
      pkgshare.install "examples/fortran/"
      pkgshare.install "examples/ExampleDataFiles/"
      inreplace pkgshare/"fortran/Makefile", "../../lib", "/usr/local/lib"
      inreplace pkgshare/"fortran/Makefile", "../../modules", "/usr/local/include"
    end

    lib.install "lib/libSHTOOLS.a"
    lib.install "lib/libSHTOOLS-mp.a" if build.with?("openmp")
    include.install "modules/fftw3.mod", "modules/planetsconstants.mod", "modules/shtools.mod", "modules/ftypes.mod"
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
                   "LAPACK=-framework accelerate",
                   "BLAS="
  end
end
