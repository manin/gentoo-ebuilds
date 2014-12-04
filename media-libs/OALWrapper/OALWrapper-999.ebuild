# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="A wrapper library for OpenAL. Makes using OpenAL alot easier."
HOMEPAGE="http://frictionalgames.github.com/OALWrapper/"
EGIT_REPO_URI="https://github.com/FrictionalGames/OALWrapper.git"

LICENSE="zlib"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-libs/openal"
RDEPEND="${DEPEND}"

src_prepare(){
	epatch "${FILESDIR}/${P}-memcpy.patch"
	epatch "${FILESDIR}/${P}-install.patch"
}
