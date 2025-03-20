# Maintainer: Carlos Aznarán <caznaranl@uni.pe>
# Contributor: Guillaume Dolle  <dev at gdolle.com>
pkgname=micromamba
_pkgname=${pkgname/micro/}
pkgver=2.0.8
pkgrel=1
pkgdesc="The fast cross-platform package manager"
arch=(i686 x86_64)
url="https://github.com/${_pkgname}-org/${_pkgname}"
license=(BSD-3-Clause)
depends=(python fmt libsolv reproc yaml-cpp simdjson)
makedepends=(cli11 spdlog tl-expected nlohmann-json cmake pybind11) # gtest
source=(${pkgname}-${pkgver}.tar.gz::${url}/archive/${pkgver}.tar.gz)
sha512sums=('88cb599a431f0859b2a60178f2b0c97291f9b6922c2bd720d2fcf723f20352ade2bc96c49ba108d29e541750e3729bf1acf7524e0c3d8679f56b07d9f58ffe43')
provides=("libmamba=${pkgver}" "python-libmambapy=${pkgver}")
conflicts=('micromamba-bin')

build() {
  cmake \
    -S ${_pkgname}-${pkgver} \
    -B build \
    -DBUILD_SHARED=ON \
    -DCMAKE_BUILD_TYPE=None \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILD_LIBMAMBA=ON \
    -DBUILD_LIBMAMBAPY=ON \
    -DBUILD_LIBMAMBA_TESTS=OFF \
    -DBUILD_MAMBA_PACKAGE=OFF \
    -DBUILD_MICROMAMBA=ON \
    -DBUILD_STATIC=OFF \
    -Wno-dev
  cmake --build build
}

check() {
  ctest --test-dir build
}

package() {
  DESTDIR="${pkgdir}" cmake --build build --target install
  install -Dm 644 ${_pkgname}-${pkgver}/${pkgname}/LICENSE -t "${pkgdir}/usr/share/licenses/${pkgname}"
}
