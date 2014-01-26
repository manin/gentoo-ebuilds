# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WEBAPP_MANUAL_SLOT="yes"
PYTHON_COMPAT=(python{2_6,2_7})

inherit eutils git-2 distutils webapp depend.apache

DESCRIPTION="Cobbler provisioning tool"
HOMEPAGE="http://www.cobblerd.org/"
EGIT_REPO_URI="git://github.com/cobbler/cobbler.git"
EGIT_BRANCH="release24"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"

RDEPEND=">=www-servers/apache-2.2.24
	dev-python/py-xmlrpc
	dev-python/cheetah
	dev-python/pyyaml
	dev-python/netaddr
	dev-python/simplejson
	dev-python/urlgrabber
	sys-boot/syslinux
	www-apache/mod_wsgi
	dev-python/pykickstart
	app-arch/createrepo
	dev-python/django
	app-emulation/virtinst
	net-ftp/tftp-hpa" # Other could be used like 'atftpd' select with use flags.
#	sys-apps/debmirror
DEPEND="${RDEPEND}"

need_apache2 rewrite proxy_http proxy

pkg_setup() {
	webapp_pkg_setup
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-setup.patch"
	epatch "${FILESDIR}/${P}-action_check.patch"
	cp "${FILESDIR}/utils.py" "${S}/cobbler/"
	cp "${FILESDIR}/cobbler_web.conf" "${S}/config/"
	sed -i  -e "s|__GENTOO_WEB_CONF__|/etc/apache2/modules.d/|g" \
			-e "s|__GENTOO_WEB_ROOT__|${VHOST_ROOT}/${VHOST_HTDOCS_INSECURE}/|g" \
			-e "/initpath/d" \
			"${S}/setup.py"
	find "${S}" -name "*.py" -exec sed -i -e "s|/var/www/cobbler/|${VHOST_ROOT}/${VHOST_HTDOCS_INSECURE}/${PN}/|g" '{}' \;
	find "${S}/config" -type f -exec sed -i -e "s|/var/www/cobbler|${VHOST_ROOT}/${VHOST_HTDOCS_INSECURE}/${PN}|g" '{}' \;
}

src_install() {
	distutils_src_install
	doinitd "${FILESDIR}/cobblerd"
	fowners -R apache:apache /usr/share/cobbler/web/ 
	fowners -R apache:apache /var/lib/cobbler/webui_sessions/ 
}

pkg_postinst() {
	elog "You have to enable WSGI mod on Apache"
	elog "Just add \"-D WSGI\" to /etc/conf.d/apache2"
	elog ""
	elog "Please check apache config files on /etc/apache2/modules.d/cobbler* an restart apache"
	elog ""
	elog "Create /tftpboot if you want to use tftp"
	elog "Run \"cobbler check\" and \"cobbler sync\""
	distutils_pkg_postinst
}
