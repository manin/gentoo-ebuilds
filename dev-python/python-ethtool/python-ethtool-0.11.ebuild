# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_2})

inherit distutils-r1 eutils

DESCRIPTION="python version of ethtool"
HOMEPAGE="https://fedorahosted.org/python-ethtool/"
SRC_URI="https://fedorahosted.org/releases/p/y/python-ethtool/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
