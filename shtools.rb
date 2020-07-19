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

    if build.with? "openmp"
      system "make", "fortran-mp"
    end

    if build.with? "examples"
      pkgshare.install "examples/fortran/"
      pkgshare.install "examples/ExampleDataFiles/"
      inreplace pkgshare/"fortran/Makefile", "../../lib", "/usr/local/lib"
      inreplace pkgshare/"fortran/Makefile", "../../modules", "/usr/local/include"
    end

    lib.install "lib/libSHTOOLS.a"
    include.install "modules/fftw3.mod", "modules/planetsconstants.mod", "modules/shtools.mod", "modules/ftypes.mod"
    share.install "man"

    if build.with? "openmp"
      lib.install "lib/libSHTOOLS-mp.a"
    end
  end

  def caveats
    <<~EOS
      To use SHTOOLS with your gfortran code, compile with the options
        -I/usr/local/include -m64 -O3 -lSHTOOLS -lfftw3 -lm -framework accelerate
      To run the test suite (must install with the option --with-examples):
        make -C /usr/local/share/shtools/fortran LAPACK="-framework accelerate" BLAS="" run-fortran-tests-no-timing
    EOS
  end

  test do
    FileUtils.cp_r pkgshare, testpath
    system "ls"
    system "make", "-C", "fortran",
                   "run-fortran-tests-no-timing",
                   "LAPACK=-framework accelerate",
                   "BLAS="
  end
end
