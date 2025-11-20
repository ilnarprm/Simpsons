//
//  ContentView.swift
//  Simpsons
//
//  Created by Ilnar on 16.10.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var personImage = PersonImage()
    @State private var page = 1
    @State private var refreshToken = UUID()

    var body: some View {
        TabView {
            Tab("Characters", systemImage: "person.2") {
                CharactersView(personImage: personImage, page: page, refreshToken: refreshToken)
                HStack {
                    Button("Prev") {
                        guard page > 1 else { return }
                        page -= 1
                        Task {
                            await personImage.getImage(forPage: page)
                            refreshToken = UUID()
                        }
                    }
                    .disabled(page <= 1 || personImage.image.pages == 1)
                    Text("\(page)/\(personImage.image.pages)")
                    Button("Next") {
                        guard page < personImage.image.pages else { return }
                        page += 1
                        Task {
                            await personImage.getImage(forPage: page)
                            refreshToken = UUID()
                        }
                    }
                    .disabled(page >= personImage.image.pages)
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .padding([.bottom, .leading, .trailing])
            }
            Tab("Episodes", systemImage: "display") {
                //EpisodesView()
            }
            Tab("Locations", systemImage: "location") {
                //LocationsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
