#!/bin/bash

# MIT License
#
# Copyright (C) 2016-2017 Volebo <dev@volebo.net>
# Copyright (C) 2016-2017 Maksim Koryukov <maxkoryukov@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

package_repo_slug=${TRAVIS_REPO_SLUG:-'UNKNOWN'}
package_name=$package_repo_slug
package_tag=${TRAVIS_TAG:-'x.x.x'}

slack_icon_emoji=":package:"
slack_username=${SLACK_USERNAME:-"travis-ci-autodeploy"}
slack_channel=${SLACK_CHANNEL:-"#autonotification"}
slack_hook=""

if [ -n "${SLACK_HOOK}" ]; then
	slack_hook="${SLACK_HOOK}"
else
	echo "Slack hook is undefined."
	exit 1
fi

# more about formatting : https://api.slack.com/docs/messages/builder

pl="{
	\"icon_emoji\": \"${slack_icon_emoji}\",
	\"channel\": \"${slack_channel}\",
	\"username\": \"${slack_username}\",
	\"text\": \"*<https://github.com/${package_repo_slug}|Package ${package_name}>* was published, tag *${package_tag}*\",
	\"attachments\": [
		{
			\"color\": \"#36a64f\",
			\"footer\": \"${slack_username}\",
			\"footer_icon\": \"https://cdn.travis-ci.com/images/favicon.png\",
			\"ts\": $(date +%s)
		}
	]
}"

echo 'Send Slack notification'
res=$(curl -X POST --data-urlencode "payload=${pl}" "${slack_hook}")
echo "Result: ${res}"

exit 0
