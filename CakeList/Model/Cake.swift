//
//  Cake.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

struct Cake: Codable, Hashable, Identifiable {
    let title: String
    let desc: String
    let image: URL

    var id: String {
        title
    }
}
