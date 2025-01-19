// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let foundation = "LSFoundation"
private let foundationTests = "LSFoundationTests"

let package = Package(
    name: foundation,
    defaultLocalization: "en",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: foundation,
                 targets: [foundation]),
    ],
    dependencies: [],
    targets: [
        .target(name: foundation,
                dependencies: []),
        .testTarget(name: foundationTests,
                    dependencies: [
                        .byName(name: foundation)
                    ],
                    resources: [.process("Resources")]),
    ]
)
