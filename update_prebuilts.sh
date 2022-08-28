#!/bin/bash

RELEASES=$(curl -s https://api.github.com/repos/bromite/bromite/releases/latest)

LATEST_VERSION=$(jq -r '.tag_name' <<<"${RELEASES}")

git log --pretty=format:'%s' | grep -q "${LATEST_VERSION}" && echo "Packages are up to date" && exit 0

APKS=(
	arm_SystemWebView.apk arm_ChromePublic.apk
	arm64_SystemWebView.apk arm64_ChromePublic.apk
	x64_SystemWebView.apk x64_ChromePublic.apk
	x86_SystemWebView.apk x86_ChromePublic.apk
)

rm prebuilt/*

for apk in "${APKS[@]}"; do
	DOWNLOAD_URL="$(jq -r '.assets | .[] | select(.name=='\"${apk}\"') | .browser_download_url' <<<"${RELEASES}")"
	wget "${DOWNLOAD_URL}" -O "prebuilt/${apk}"
	7z a -txz -v100m "prebuilt/${apk/x64/x86_64}.xz" "prebuilt/${apk}" && rm "prebuilt/${apk}"
done
