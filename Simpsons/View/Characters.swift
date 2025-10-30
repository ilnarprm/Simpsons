//
//  Characters.swift
//  Simpsons
//
//  Created by Ilnar on 19.10.2025.
//

import SwiftUI

struct Characters: View {
    @StateObject private var personImage = PersonImage()
    @State private var page = 1

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 50, maximum: .infinity)), GridItem(.flexible(minimum: 50, maximum: .infinity))
            ], spacing: 10) {
                ForEach(personImage.image.results, id: \.id) { person in
                    LazyVStack {
                        PersonCard(person: person)
                    }
                }
            }
            //.padding()
        }
        .padding()
        .onAppear {
            Task {
                await personImage.getImage(forPage: page)
            }
        }
    }
}

#Preview {
    Characters()
}

