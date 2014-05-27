# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.10.0-r1.ebuild,v 1.8 2014/04/26 08:15:47 pacho Exp $

EAPI=5

BACKPORTS=1cd29748

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit gnome2 distutils-r1

DESCRIPTION="A graphical tool for administering virtual machines"
HOMEPAGE="http://virt-manager.org"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="git://git.fedorahosted.org/virt-manager.git"
else
	SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="gnome-keyring policykit sasl"

RDEPEND="!app-emulation/virtinst
	x11-libs/gtk+:3[introspection]
	|| (
		dev-python/libvirt-python[${PYTHON_USEDEP}]
		>=app-emulation/libvirt-0.7.0[python(-),${PYTHON_USEDEP}]
	)
	>=app-emulation/libvirt-glib-0.0.7[introspection,python,${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	dev-libs/libxml2[python,${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/urlgrabber[${PYTHON_USEDEP}]
	gnome-base/dconf
	>=net-libs/gtk-vnc-0.3.8[gtk3,introspection,python,${PYTHON_USEDEP}]
	net-misc/spice-gtk[gtk3,introspection,python,sasl?,${PYTHON_USEDEP}]
	x11-libs/vte:2.90[introspection]
	gnome-keyring? ( dev-python/gnome-keyring-python )
	policykit? ( sys-auth/polkit[introspection] )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool"

DOCS=( README NEWS )

distutils-r1_python_compile() {
	local defgraphics=

	esetup.py configure \
		--qemu-user=qemu \
		--default-graphics=spice
}

python_install_all() {
	distutils-r1_python_install_all
	python_fix_shebang \
		"${ED}"/usr/share/virt-manager/virt-{clone,convert,image,install,manager}
}

pkg_preinst() {
	gnome2_pkg_preinst

	cd "${ED}"
	export GNOME2_ECLASS_ICONS=$(find 'usr/share/virt-manager/icons' -maxdepth 1 -mindepth 1 -type d 2> /dev/null)
}
