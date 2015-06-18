# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils flag-o-matic git-r3

DESCRIPTION="Raspberry Pi userspace tools and libraries"
HOMEPAGE="https://github.com/raspberrypi/firmware"
EGIT_REPO_URI="https://github.com/raspberrypi/firmware.git"
EGIT_CLONE_TYPE="shallow"
LICENSE="BSD GPL-2 raspberrypi-videocore-bin"
SLOT="0"
KEYWORDS="~arm -*"
IUSE="+hardfp examples"

RDEPEND="!media-libs/raspberrypi-userland"
RDEPEND="${DEPEND}"

RESTRICT="binchecks"

src_prepare() {
	rm {,hardfp/}opt/vc/LICENCE || die
}

src_install() {
	cd $(usex hardfp hardfp/ "")opt/vc || die

	insinto /opt/vc
	doins -r include
	into /opt
	dobin bin/*
	dosbin sbin/*
	into /opt/vc
	dolib.so lib/*.so
	dolib.a lib/*.a
	dolib.so lib/plugins/*.so

	insinto /usr/share/doc/${PF}/examples
	use examples && doins -r src/hello_pi

	#doenvd "${FILESDIR}"/04${PN}
}
