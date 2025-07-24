# Maintainer: Carlos Aznarán <caznaranl@uni.pe>
# Co-Maintainer: Brian Thompson <brianrobt@pm.me>
# Contributor: Guillaume Dolle  <dev at gdolle.com>

# Rewriter: Evan Greenup: Now the content in here is quite different from previous share build of micromamba on AUR. It is not statically build and not include libmambapy.

pkgname=micromamba
_pkgname=mamba
pkgver=2.3.0
pkgrel=2
pkgdesc="The fast cross-platform package manager"
arch=(i686 x86_64)
url="https://github.com/${_pkgname}-org/${_pkgname}"
license=(BSD-3-Clause)
depends=()
makedepends=(
  pixi
)
source=(
  ${pkgname}-${pkgver}.tar.gz::${url}/archive/${pkgver}.tar.gz
)
sha512sums=('580afeddd18c7a3f41c2138d3a3ccdcd2b86faa126c7279f78036462b52fa205387d7421c197cb8ba19ad0117730be9077b07d5d62cd6cb6e55c68fa6da2261a')
provides=(
  "libmamba=${pkgver}"
)
conflicts=(
  'micromamba-bin'
)

prepare() {
  mkdir -p ${srcdir}/pixi_proj
  cd "${srcdir}/${_pkgname}-${pkgver}"
  pixi init --import dev/environment-micromamba-static.yml ${srcdir}/pixi_proj
}

build() {
  cd "${srcdir}/${_pkgname}-${pkgver}"
  eval "$(pixi shell-hook --manifest-path ${srcdir}/pixi_proj/pixi.toml)"
  mkdir build
  cmake \
    -S . \
    -B build/ \
    -G Ninja \
    -D CMAKE_INSTALL_PREFIX="/usr" \
    -D CMAKE_BUILD_TYPE=Release \
    -D BUILD_LIBMAMBA=ON \
    -D BUILD_MICROMAMBA=ON \
    -D BUILD_STATIC=ON
  cmake --build build/
}

check() {
  cd "${srcdir}/${_pkgname}-${pkgver}"
  eval "$(pixi shell-hook --manifest-path ${srcdir}/pixi_proj/pixi.toml)"
  ctest --test-dir build
}

package() {
    # Install main components (C++ library, executables, headers)
    DESTDIR="${pkgdir}" cmake --build build --target install
}
