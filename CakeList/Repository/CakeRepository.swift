//
//  CakeRepository.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

final class CakeRepository: CakeRepositoryProtocol {

    private let service: CakeServiceProtocol

    init(service: CakeServiceProtocol = CakeAPIService()) {
        self.service = service
    }

    func getCakes() async throws -> [Cake] {
        try await service.fetchCakes()
    }
}
