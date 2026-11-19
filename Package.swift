// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ItauHttpClient",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "ItauHttpClient", targets: ["ItauHttpClient"])
    ],
    targets: [
        .target(name: "ItauHttpClient"),
        .testTarget(name: "ItauHttpClientTests", dependencies: ["ItauHttpClient"])
    ],
    swiftLanguageModes: [.v5]
)
