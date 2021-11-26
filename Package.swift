// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "AdventOfCode2020",
            targets: ["AdventOfCode2020"]),
        .executable(
            name: "aoc20",
            targets: ["aoc20"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
        .package(url: "https://github.com/apple/swift-algorithms", .branch("main"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventOfCode2020",
            dependencies: [.product(name: "Algorithms", package: "swift-algorithms")],
            resources: [.process("Inputs")]),
        .testTarget(
            name: "AdventOfCode2020Tests",
            dependencies: ["AdventOfCode2020"]),
        .target(
            name: "aoc20",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "AdventOfCode2020"])
    ]
)
