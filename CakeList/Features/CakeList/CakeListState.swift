//
//  CakeListState.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

enum CakeListState {
    case idle
    case loading
    case loaded([Cake])
    case error(String)
}
