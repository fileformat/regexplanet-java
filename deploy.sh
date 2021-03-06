#!/bin/bash
#
# deploy to AppEngine
#

set -o errexit
set -o pipefail
set -o nounset

xmlstarlet edit --inplace --update "//_:property[@name='COMMIT']/@value" -v $(git rev-parse --short HEAD) www/WEB-INF/appengine-web.xml
xmlstarlet edit --inplace --update "//_:property[@name='LASTMOD']/@value" -v $(date -u +%Y-%m-%dT%H:%M:%SZ) www/WEB-INF/appengine-web.xml

/usr/local/appengine-java-sdk/bin/appcfg.sh --oauth2 update www/

xmlstarlet edit --inplace --update "//_:property[@name='COMMIT']/@value" -v dev www/WEB-INF/appengine-web.xml
xmlstarlet edit --inplace --update "//_:property[@name='LASTMOD']/@value" -v dev www/WEB-INF/appengine-web.xml
