//
//  CakeListViewModel.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import Foundation

@MainActor
final class CakeListViewModel: ObservableObject {

    @Published private(set) var state: CakeListState = .idle

    private let repository: CakeRepositoryProtocol

    init(repository: CakeRepositoryProtocol = CakeRepository()) {
        self.repository = repository
    }

    func loadCakes() async {
        state = .loading

        do {
            let cakes = try await repository.getCakes()

            let uniqueCakes = removeDuplicates(from: cakes)

            let sortedCakes = uniqueCakes.sorted {
                $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending
            }

            state = .loaded(sortedCakes)

        } catch {
            state = .error("Unable to load cakes. Please try again.")
        }
    }

    func refresh() async {
        await loadCakes()
    }

    private func removeDuplicates(from cakes: [Cake]) -> [Cake] {
        var seenTitles = Set<String>()

        return cakes.filter { cake in
            seenTitles.insert(cake.title.lowercased()).inserted
        }
    }
}
