// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YuSPM",
    platforms: [
        // [주의] 외부 라이브러리가 추가된 상태에서 OS를 지정해주어야 한다
        .iOS(.v10),
        .macOS(.v10_12) // SnapKit, Alamofire 의 최소 macOS 10.12로 인하여 추가
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "YuSPM",
            targets: ["YuSPM"]),
    ], dependencies: [
        // 외부 패키지 설정
        .package(name:"Alamofire", url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.3")),
        .package(name:"SnapKit", url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(name:"RxSwift", url: "https://github.com/ReactiveX/RxSwift.git", .exact("6.2.0")),
        .package(name:"RxDataSources", url: "https://github.com/RxSwiftCommunity/RxDataSources.git", .exact("5.0.0"))
    ], targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "YuSPM",
            dependencies: [
                // 외부 패키지 리스트
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxDataSources", package: "RxDataSources")
            ],
            // 라이브러리 그룹 경로
            path: "Sources"
        ),
        .testTarget(
            name: "YuSPMTests",
            dependencies: ["YuSPM"]),
    ], swiftLanguageVersions: [
        // swift 언어설정
        .v5
    ]
)
