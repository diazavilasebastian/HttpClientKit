// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ItauHttpClient",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ItauHttpClient", targets: ["ItauHttpClient"])
    ],
    targets: [
        .target(name: "ItauHttpClient")
    ],
    swiftLanguageModes: [.v5]
)
