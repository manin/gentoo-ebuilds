# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic git-2 toolchain-funcs

DESCRIPTION="command line media player for the Raspberry Pi"
HOMEPAGE="https://github.com/popcornmix/omxplayer"
EGIT_REPO_URI="https://github.com/popcornmix/omxplayer.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libpcre
	dev-libs/boost
	media-libs/raspberrypi-userland-bin
	media-video/ffmpeg
	sys-apps/dbus"
RDEPEND="${RDEPEND}
	sys-apps/fbset"

src_prepare() {
	sed -e ' /^\(sudo\|read\)/ s/^#*/#/' -i prepare-native-raspbian.sh
	sed -e ' /\(g++\|gcc\)/ s/-.*//' -i prepare-native-raspbian.sh
	sed -e '/cp -a ffmpeg_compiled/d' -i Makefile
	./prepare-native-raspbian.sh
	tc-export CXX
	filter-ldflags -Wl,--as-needed
}

src_install() {
	dobin ${PN}{,.bin}
	dodoc README.md
}
