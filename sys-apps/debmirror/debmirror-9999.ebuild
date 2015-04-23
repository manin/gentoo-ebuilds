# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Debian partial mirror script, with ftp and package pool support"
HOMEPAGE="http://packages.debian.org/es/sid/debmirror"
EGIT_REPO_URI="git://git.debian.org/collab-maint/debmirror.git"
#EGIT_BRANCH="release24"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

DEPEND="app-arch/bzip2
	virtual/perl-Digest-MD5
	virtual/perl-Digest-SHA
	virtual/perl-digest-base
	virtual/perl-libnet
	dev-perl/LockFile-Simple
	dev-perl/libwww-perl
	dev-lang/perl
	net-misc/rsync"
RDEPEND="${DEPEND}"
