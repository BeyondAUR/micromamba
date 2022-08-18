# Maintainer: Guillaume Dolle  <dev at gdolle.com>
pkgname=micromamba
_pkgname=${pkgname/micro/}
pkgver=0.25.0
_pkgver=2022.07.26
pkgrel=1
pkgdesc="C++ tiny version of mamba, the fast conda package installer"
arch=('i686' 'x86_64')
url="https://github.com/mamba-org/mamba"
license=('MIT')
depends=('libarchive' 'cmake' 'curl' 'libsolv' 'cli11' 'pybind11' 'fmt' 'spdlog' 'nlohmann-json' 'python-pip' 'yaml-cpp' 'reproc' 'cpp-ghc-filesystem' 'termcolor' 'tl-expected')
makedepends=('gtest')
source=(${pkgname}-${pkgver}.tar.gz::https://github.com/mamba-org/mamba/archive/refs/tags/${_pkgver}.tar.gz )
md5sums=('e3029ca5710931cff695598aedec8a61')
provides=('micromamba')
conflict=('micromamba-bin')

prepare(){
  cd ${_pkgname}-${_pkgver}
  #patch --forward --strip=1 --input="${srcdir}/${_pkgname}-${_pkgver}.patch"

  cmake -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${pkgdir}/usr \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
        -DBUILD_LIBMAMBA=ON \
        -DBUILD_LIBMAMBAPY=ON \
        -DBUILD_LIBMAMBA_TESTS=OFF \
        -DBUILD_MAMBA_PACKAGE=OFF \
        -DBUILD_MICROMAMBA=ON \
        -DBUILD_SHARED=ON \
        -DBUILD_STATIC=ON \
        -B build
}

build() {
  cd ${_pkgname/micro/}-${_pkgver}
  cmake --build build
}

check() {
  cd ${_pkgname}-${_pkgver}/build
  ctest
}

package() {
  cd ${_pkgname}-${_pkgver}
  cmake --install build
}
