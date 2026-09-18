//
//  CakeRowView.swift
//  CakeList
//
//  Created by shikha on 18/09/26.
//

import SwiftUI

struct CakeRowView: View {

    let cake: Cake

    var body: some View {
        HStack(spacing: 16) {

            AsyncImage(url: cake.image) { phase in
                switch phase {

                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()

                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 80, height: 80)

                @unknown default:
                    EmptyView()
                }
            }

            Text(cake.title)
                .font(.headline)

            Spacer()
        }
        .padding(.vertical, 8)
    }
}
