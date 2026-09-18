//
//  CakeRepositoryProtocol.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

protocol CakeRepositoryProtocol {
    func getCakes() async throws -> [Cake]
}
