FROM brianrobt/archlinux-aur-dev:latest

# Copy local AUR package files to the container
COPY --chown=builder:builder .SRCINFO PKGBUILD *.patch ./

# Install build dependencies.  Example for python-conda:
RUN yay -S --noconfirm \
  python \
  fmt \
  libsolv \
  reproc \
  yaml-cpp \
  simdjson \
  cli11 \
  spdlog \
  tl-expected \
  nlohmann-json \
  cmake \
  pybind11

# Build the package
RUN makepkg -si --noconfirm
