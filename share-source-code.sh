#!/bin/bash

if [ -z "$TEMP" ]; then
	TEMP='/tmp'
fi

set -x

find sources -name .git > "$TEMP/tc-file-lists"
cat "$TEMP/tc-file-lists"
tar -czf sources.tar.gz --files-from "$TEMP/tc-file-lists"

