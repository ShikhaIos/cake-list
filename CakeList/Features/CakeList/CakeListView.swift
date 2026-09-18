//
//  CakeListView.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import SwiftUI

struct CakeListView: View {

    @StateObject private var viewModel = CakeListViewModel()

    @State private var selectedCake: Cake?

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Cakes")
        }
        .task {
            await viewModel.loadCakes()
        }
        .alert(item: $selectedCake) { cake in
            Alert(
                title: Text(cake.title),
                message: Text(cake.desc),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    @ViewBuilder
    private var content: some View {

        switch viewModel.state {

        case .idle:
            ProgressView()

        case .loading:
            ProgressView("Loading cakes...")

        case .loaded(let cakes):
            cakeList(cakes)

        case .error(let message):
            errorView(message)
        }
    }

    private func cakeList(_ cakes: [Cake]) -> some View {
        List(cakes) { cake in
            CakeRowView(cake: cake)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedCake = cake
                }
        }
        .listStyle(.plain)
        .refreshable {
            await viewModel.refresh()
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {

            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)

            Text(message)
                .multilineTextAlignment(.center)

            Button("Retry") {
                Task {
                    await viewModel.loadCakes()
                }
            }
        }
        .padding()
    }
}
