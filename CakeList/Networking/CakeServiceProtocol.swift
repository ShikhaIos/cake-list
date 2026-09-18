//
//  CakeServiceProtocol.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

protocol CakeServiceProtocol {
    func fetchCakes() async throws -> [Cake]
}
