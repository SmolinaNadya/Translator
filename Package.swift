// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Translator",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url:"https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url:"https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Translator",
            dependencies:  [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            .product(name: "Vapor", package: "vapor"),
            .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"), 
            .product(name: "Fluent", package: "fluent")
            ],
            path: "Sources/Translator",
            resources: [
                .process("data.json")
            ]),
            .target(
            name: "App",
            dependencies:  ["Translator"],
            path: "Sources/App"
           ),
           .target(
               name: "API",
               dependencies: ["Translator"]
           ),
           .target(
               name: "RunAPI",
               dependencies: ["API"]
           ),
        .testTarget(
            name: "TranslatorTests",
            dependencies: ["Translator"]),
    ]
)
