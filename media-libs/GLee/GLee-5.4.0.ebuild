# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools

DESCRIPTION="OpenGL Easy Extension library"
HOMEPAGE="http://elf-stone.com/glee.php"
SRC_URI="http://elf-stone.com/downloads/${PN}/${P}-src.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

S="$(dirname ${S})"

src_prepare() {
	epatch "${FILESDIR}/${PN}-autotools.patch"
	eautoreconf || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc readme.txt extensionList.txt || die
}
