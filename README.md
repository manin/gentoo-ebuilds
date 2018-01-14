INSTALL
=======
Drop gentoo-manin.xml into /etc/layman/overlays

<code>
layman -a gentoo-manin
<code>

gentoo-ebuilds
==============

* VisualStudio Code
  * Builds from source so it keeps the MIT license. As per https://github.com/Microsoft/vscode/issues/60 the extension service is not configured. It can be configured at /usr/share/code-oss/resources/app/product.json adding the entry with a provider, for example the MS one:

```json
        "extensionsGallery": {
                "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
                "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",
                "itemUrl": "https://marketplace.visualstudio.com/items"
        }
```

* synfig
* synfigstudio
* ETL
* cobbler:
Under development
* virt-manager
* debmirror
* yum-utils
* pykickstart
* GLee
* OALWrapper - HPLEngine1 dependency
* omxplayer
