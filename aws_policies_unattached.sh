#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-01-07 11:57:18 +0000 (Tue, 07 Jan 2020)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/harisekhon
#

# Lists all unattached policies

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x

aws iam list-policies |
# get json to allow to filter later
#jq -r '.Policies[] | select(.IsAttachable==true) | select (.AttachmentCount==0)'
jq -r '.Policies[] | select(.IsAttachable==true) | select (.AttachmentCount==0) | [.PolicyId, .PolicyName, .CreateDate, .UpdateDate] | @tsv' |
sort -k2 |
column -t
