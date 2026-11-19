// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "HttpClientKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "HttpClientKit", targets: ["HttpClientKit"])
    ],
    targets: [
        .target(name: "HttpClientKit"),
        .testTarget(name: "HttpClientKitTests", dependencies: ["HttpClientKit"])
    ],
    swiftLanguageModes: [.v5]
)
