# Maintainer: Carlos Aznarán <caznaranl@uni.pe>
# Co-Maintainer: Brian Thompson <brianrobt@pm.me>
# Contributor: Guillaume Dolle  <dev at gdolle.com>

pkgname=micromamba
_pkgname=${pkgname/micro/}
pkgver=2.2.0
pkgrel=1
pkgdesc="The fast cross-platform package manager"
arch=(i686 x86_64)
url="https://github.com/${_pkgname}-org/${_pkgname}"
license=(BSD-3-Clause)
depends=(
  python
  fmt
  libsolv
  reproc
  yaml-cpp
  simdjson
)
makedepends=(
  cli11
  spdlog
  tl-expected
  nlohmann-json
  cmake
  pybind11
)
source=(${pkgname}-${pkgver}.tar.gz::${url}/archive/${pkgver}.tar.gz
    static-off.patch
    utils.cpp.patch
)
sha512sums=('e17f22ad0025fb802cf29830a3449e6b35bbca5bd319196904557993a825868007247fbf1651517864439de5224ebdb76d532bd1340a3021360ac93530526102'
    'SKIP'
    'SKIP'
)
provides=("libmamba=${pkgver}" "python-libmambapy=${pkgver}" "mamba=${pkgver}")
conflicts=('micromamba-bin' 'python-libmamba')

prepare() {
  cd ${_pkgname}-${pkgver}
  patch -p0 -i ../../static-off.patch
  patch -p0 -i ../../utils.cpp.patch
}

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