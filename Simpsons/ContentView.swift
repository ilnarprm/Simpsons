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

    var body: some View {
        TabView {
            Tab("Characters", systemImage: "person.2") {
                Characters()
                HStack {
                    Button("Prev") {
                        guard page > 1 else { return }
                        page -= 1
                        Task {
                            await personImage.getImage(forPage: page)
                        }
                    }
                    Text("\(page)/\(personImage.image.pages)")
                    Button("Next") {
                        guard page < personImage.image.pages else { return }
                        page += 1
                        Task {
                            await personImage.getImage(forPage: page)
                        }
                    }
                }
                .buttonStyle(.glassProminent)
                .buttonSizing(.flexible)
                .padding(.bottom)
                .padding(.leading)
                .padding(.trailing)
                //.frame(maxWidth: .infinity, alignment: .leading) // <--- Выровнять по левому краю
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
