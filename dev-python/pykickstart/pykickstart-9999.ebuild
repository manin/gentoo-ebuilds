# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_COMPAT=(python{2_6,2_7})

inherit eutils git-2 distutils

DESCRIPTION="python library that is used for reading and writing kickstart files"
HOMEPAGE="https://fedoraproject.org/wiki/Pykickstart"
EGIT_REPO_URI="git://git.fedorahosted.org/git/pykickstart.git"
#EGIT_BRANCH="release24"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~x86 ~x86-fbsd"

