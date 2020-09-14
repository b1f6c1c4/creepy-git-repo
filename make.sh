#!/bin/bash

set -eux

ZT="$(git mktree </dev/null)"
RD="$(git hash-object -w --stdin <<EOF
# Just being creepy.
EOF
)"
T="$(git mktree <<EOF
040000 tree $ZT$(printf '\t').git$(printf '\r')
100644 blob $RD$(printf '\t')README.md
EOF
)"

C="$(git hash-object -t commit -w --stdin <<EOF
tree $T
author $(printf '\u200b') <> 9223372036854775807 +0000
committer $(printf '\u200b') <> 9223372036854775807 +0000
gpgsig 7Bvwz4

$(printf '\u200b')
EOF
)"

git push --force origin "$C:refs/heads/creepy"

# http POST https://api.github.com/repos/b1f6c1c4/creepy-git-repo/git/commits \
#     "Authorization: token $(cat ~/.github-token)" \
#     "tree=$T" \
#     'parents:=[
#         "ab72dd1aba052ea550e8a2ef20a7716ccdf29e1f",
#         "1b2879404fd763b41fea234d24b008247d6d52c8",
#         "856deb866d16e29bd65952e0289066f6078af773",
#         "9717201338f7b898eaeb759f17f67f4793590903",
#         "0f5ac5dc8f944a719e7d71729c0a63e1cfc9c6b5",
#         "54e85e7af1ac9e9a92888060d6811ae767fea1bc",
#         "da38e7b5ca6127b2e385aeeefbdf496f8d72bc61"
#     ]' \
#     'author:={
#         "date":"1970-01-01T00:00:00.000Z",
#         "name":"\u200b",
#         "email":""
#     }' \
#     'committer:={
#         "date":"1970-01-01T00:00:00.000Z",
#         "name":"\u200b",
#         "email":""
#     }' \
#     'message:="\u200b"'
