# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="yum utils"
HOMEPAGE="http://yum.baseurl.org"
EGIT_REPO_URI="git://yum.baseurl.org/yum-utils.git"
#EGIT_BRANCH="release24"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

DEPEND="sys-apps/yum"
RDEPEND="${DEPEND}"
