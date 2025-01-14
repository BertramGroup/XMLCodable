// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if swift(>=5.9)
let platforms: [PackageDescription.SupportedPlatform] = [.macOS(.v10_13), .iOS(.v12), .watchOS(.v4), .tvOS(.v12)]
#elseif swift(>=5.7)
let platforms: [PackageDescription.SupportedPlatform] = [.macOS(.v10_13), .iOS(.v11), .watchOS(.v4), .tvOS(.v11)]
#elseif swift(>=5.0)
let platforms: [PackageDescription.SupportedPlatform]? = nil
#endif

let package = Package(
    name: "XMLCodable",
    platforms: platforms,
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "XMLCodable",
            targets: ["XMLCodable"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "XMLCodable",
            dependencies: [],
            path: "Sources/XMLCoder"
        ),
        .testTarget(
            name: "XMLCoderTests",
            dependencies: ["XMLCodable"]
        ),
    ]
)
