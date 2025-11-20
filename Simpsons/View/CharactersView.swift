//
//  Characters.swift
//  Simpsons
//
//  Created by Ilnar on 19.10.2025.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var personImage: PersonImage
    let page: Int
    let refreshToken: UUID

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: .infinity)),
                GridItem(.flexible(minimum: 50, maximum: .infinity))
            ], spacing: 10) {
                ForEach(personImage.image.results, id: \.id) { person in
                    LazyVStack {
                        PersonCardView(person: person, refreshToken: refreshToken)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                await personImage.getImage(forPage: page)
            }
        }
        .refreshable {
            await personImage.getImage(forPage: page)
        }
    }
}

#Preview {
    // Пример для превью, создаём PersonImage с тестовыми данными
    CharactersView(personImage: PersonImage(), page: 1, refreshToken: UUID())
}
