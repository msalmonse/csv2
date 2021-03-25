
#!/usr/bin/bash

dest=${PROJECT_DIR:-$PWD}
name=${1:-$PRODUCT_NAME}

cat > "$dest/appinfo.swift" <<EOD
//  Application version information automatically generated at build time.
//  Do not commit this file to your code repository.

struct AppInfo {
	static let name = "${name}"
	static let version = "$(git describe --always)"
	static let build = $(git rev-list HEAD | wc -l | tr -d ' ')
	static let hash = "$(git rev-parse HEAD)"
	static let shortHash = "$(git rev-parse --short HEAD)"
	static let origin = "$(git remote get-url origin)"
	static let builtAt = "$(date -u "+%F %T %Z")"
	static let versionInfo = ${VERSION_INFO_STRING:-0}
	static let swiftVersion = "${SWIFT_VERSION}"
}
EOD
