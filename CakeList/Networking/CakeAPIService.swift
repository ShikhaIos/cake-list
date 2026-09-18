//
//  CakeAPIService.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

final class CakeAPIService: CakeServiceProtocol {

    private let session: URLSession

    private let endpoint = URL(
        string: "https://raw.githubusercontent.com/Waracle/mobile-coding-test-api/refs/heads/main/cakes"
    )!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCakes() async throws -> [Cake] {
        let (data, response) = try await session.data(from: endpoint)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Cake].self, from: data)
    }
}
