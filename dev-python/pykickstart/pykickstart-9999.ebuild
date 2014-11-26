# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_COMPAT=(python{2_6,2_7})

inherit eutils git-2 distutils-r1

DESCRIPTION="python library that is used for reading and writing kickstart files"
HOMEPAGE="https://github.com/clumens/pykickstart"
EGIT_REPO_URI="https://github.com/clumens/pykickstart.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~x86 ~x86-fbsd"
