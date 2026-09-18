//
//  CakeListViewModelTests.swift
//  CakeListTests
//
//  Created by shikha on 18/09/26.
//

import XCTest
@testable import CakeList

final class MockCakeRepository: CakeRepositoryProtocol {

    var result: Result<[Cake], Error>

    init(result: Result<[Cake], Error>) {
        self.result = result
    }

    func getCakes() async throws -> [Cake] {
        try result.get()
    }
}

enum TestError: Error {
    case networkFailure
}

@MainActor
final class CakeListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loadCakes_whenSuccessful_removesDuplicatesAndSortsByTitle() async {

            let cakes = [
                Cake(
                    title: "Victoria Sponge",
                    desc: "Victoria sponge description",
                    image: URL(string: "https://example.com/victoria.jpg")!
                ),
                Cake(
                    title: "Chocolate Cake",
                    desc: "Chocolate cake description",
                    image: URL(string: "https://example.com/chocolate.jpg")!
                ),
                Cake(
                    title: "chocolate cake",
                    desc: "Duplicate chocolate cake",
                    image: URL(string: "https://example.com/chocolate2.jpg")!
                ),
                Cake(
                    title: "Carrot Cake",
                    desc: "Carrot cake description",
                    image: URL(string: "https://example.com/carrot.jpg")!
                )
            ]

            let repository = MockCakeRepository(
                result: .success(cakes)
            )

            let viewModel = CakeListViewModel(
                repository: repository
            )

            await viewModel.loadCakes()

            switch viewModel.state {

            case .loaded(let cakes):

                XCTAssertEqual(cakes.count, 3)

                XCTAssertEqual(
                    cakes.map(\.title),
                    [
                        "Carrot Cake",
                        "Chocolate Cake",
                        "Victoria Sponge"
                    ]
                )

            default:
                XCTFail("Expected loaded state")
            }
        }
    
    func test_loadCakes_whenRepositoryFails_presentsError() async {

        let repository = MockCakeRepository(
            result: .failure(TestError.networkFailure)
        )

        let viewModel = CakeListViewModel(
            repository: repository
        )

        await viewModel.loadCakes()

        switch viewModel.state {

        case .error(let message):
            XCTAssertEqual(
                message,
                "Unable to load cakes. Please try again."
            )

        default:
            XCTFail("Expected error state")
        }
    }

}
