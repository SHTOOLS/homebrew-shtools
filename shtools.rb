require "formula"
require 'fileutils'

class Shtools < Formula
  homepage "https://shtools.ipgp.fr" # used by `brew home example-formula`.
  url "https://github.com/SHTOOLS/SHTOOLS/archive/v3.0.tar.gz" 
  version "3.0"
  sha256 "e97ee5262a021c7ffe99535b3dd6a35ccc3d92b962b2f1f483969dbd0e5035f8"
  head "https://github.com/SHTOOLS/homebrew-shtools.git"
  
  keg_only "For the time being, this is keg only."

  depends_on "python"
  depends_on "gcc" 
  depends_on "fftw"

  def install

	ENV.prepend_path "PATH", "/usr/bin"
    ENV.prepend_path "PATH", "/System/Library/Frameworks/Python.framework/Versions/Current/Extras/bin"
	system "make"
	system "make python"

  end

  def caveats
    s = <<-EOS.undent
      Print some important notice to the user when `brew info <formula>` is
      called or when brewing a formula.
      This is optional. You can use all the vars like #{version} here.
    EOS
    s
  end

end

__END__
