# Maintainer: Carlos Aznarán <caznaranl@uni.pe>
# Contributor: Guillaume Dolle  <dev at gdolle.com>
pkgname=micromamba
_pkgname=${pkgname/micro/}
pkgver=2.1.0
pkgrel=1
pkgdesc="The fast cross-platform package manager"
arch=(i686 x86_64)
url="https://github.com/${_pkgname}-org/${_pkgname}"
license=(BSD-3-Clause)
depends=(python fmt libsolv reproc yaml-cpp simdjson)
makedepends=(cli11 spdlog tl-expected nlohmann-json cmake pybind11) # gtest
source=(${pkgname}-${pkgver}.tar.gz::${url}/archive/${pkgver}.tar.gz)
sha512sums=('ba8ee8fee6cd698775ced7b9893eb3d49192241e4da84f31a6fe92a85b31508b4e6c910ab45049a540b6bd4a371b8e799745bc51bdc2ec7db0e7ef0e83dd47ce')
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
