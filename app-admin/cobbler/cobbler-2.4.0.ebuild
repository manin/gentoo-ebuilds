# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#PYTHON_DEPEND="*:2.6"
SLOT=0
WEBAPP_MANUAL_SLOT="yes"
PYTHON_COMPAT=(python{2_6,2_7})

inherit eutils git-2 webapp distutils depend.apache

DESCRIPTION="Cobbler provisioning tool"
HOMEPAGE="http://www.cobblerd.org/"
EGIT_REPO_URI="git://github.com/cobbler/cobbler.git"
EGIT_BRANCH="release24"
#WEBAPP_NO_AUTO_INSTALL="yes"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~x86 ~x86-fbsd"

#   dev-lang/python:2.7
RDEPEND=">=www-servers/apache-2.2.24
	dev-python/py-xmlrpc
    dev-python/cheetah
	dev-python/pyyaml
    dev-python/netaddr
    dev-python/simplejson
    dev-python/urlgrabber
    sys-boot/syslinux
    net-ftp/tftp-hpa" # Other could be used like 'atftpd' select with use flags.
DEPEND="${RDEPEND}"

need_apache2 rewrite proxy_http proxy mod_wsgi

pkg_setup() {
	webapp_pkg_setup
	python_pkg_setup
}

src_prepare() {
#	webapp_src_preinst
	sed -i -e "/webroot/ s/cobbler//" "${S}"/setup.py
	epatch "${FILESDIR}/${P}-setup.patch"
	sed -i  -e "s|__GENTOO_WEB_CONF__|${MY_SERVERCONFIGDIR}/|g" \
			-e "s|__GENTOO_WEB_ROOT__|${MY_HTDOCSDIR}/|g" \
			-e "/webcontent/d" \
			-e "/cobbler_web.conf/d" \
			-e "/initpath/d" \
			"${S}/setup.py"
	sed -i -e "s|/var/www/cobbler|${VHOST_ROOT}/${VHOST_HTDOCS_INSECURE}/${PN}|g" \
			"${S}/config/cobbler.conf"
#	epatch "${FILESDIR}/${P}-make.patch"
#	rm "${S}/setup.cfg"
}

#src_install() {
#	elog ${MY_HTDOCSDIR} 
#	emake DESTDIR="${D}" LIBDIR="${D}$(python_get_sitedir)" install || die "emake install failed"
#}

src_install() {
	#dodir "${VHOST_CONFIG_DIR}"
	webapp_src_preinst
	distutils_src_install
	dosym ${MY_SERVERCONFIGDIR}/cobbler.conf /etc/apache2/modules.d/cobbler.conf
#	webapp_server_configfile apache config/cobbler.conf
	doinitd "${FILESDIR}/cobblerd"
	webapp_src_install
}

pkg_postinst() {
	elog "you have to enable WSGI mod on Apache"
	elog "Just add \"-D WSGI\" to /etc/conf.d/apache2" 
	distutils_pkg_postinst
	webapp_pkg_postinst
}
