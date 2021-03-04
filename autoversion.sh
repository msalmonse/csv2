
#!/usr/bin/bash

dest=${PROJECT_DIR:-$PWD}
name=${1:-$PRODUCT_NAME}

cat > "$dest/version.swift" <<EOD
//  Application version information automatically generated at build time.
//  Do not commit this file to your code repository.

struct AppInfo {
	static let name = "${name}"
	static let version="$(git describe --always --dirty)"
	static let build = $(git rev-list HEAD | wc -l | tr -d ' ')
	static let hash = "$(git rev-parse HEAD)"
}
EOD
