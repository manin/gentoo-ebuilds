# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit xdg-utils

DESCRIPTION="VisualStudio Code"
HOMEPAGE="http://code.visualstudio.com/"
SRC_URI="https://github.com/Microsoft/vscode/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="=net-libs/nodejs-8.9.4
	gnome-base/gconf
	sys-apps/yarn
	x11-libs/libX11
	x11-libs/libxkbfile
	app-crypt/libsecret"
DEPEND="${RDEPEND}"


src_configure() {
	if [[ $(uname -m) = "x86_64" ]]
	then
		CARCH="x64"
		IARCH="amd64"
	fi
	yarn
}

src_compile() {
	yarn run compile
	yarn run gulp electron
	yarn run gulp vscode-linux-${CARCH}-min
	yarn run gulp vscode-linux-${CARCH}-prepare-deb
}

src_install() {
	cp -R "${S}/.build/linux/deb/${IARCH}/code-oss-${IARCH}/usr/" "${D}/usr/" || die "Could not copy files"
	dosym /usr/share/code-oss/bin/code-oss /usr/bin/vscode
}

pkg_postinst(){
	xdg_desktop_database_update
}
