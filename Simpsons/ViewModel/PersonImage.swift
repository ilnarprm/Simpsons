//
//  PersonImage.swift
//  Simpsons
//
//  Created by Ilnar on 17.10.2025.
//

import Foundation
import Combine
import Playgrounds

class PersonImage: ObservableObject {
    private let network = Network()
    @Published var image: Pages

    init() {
        self.image = Pages()
        // Don't call getImage() here; ContentView will trigger correct page on appear
    }
    func getImage(forPage page: Int = 1) async {
        do {
            let result = try await network.sendRequest(page: page)
            self.image = result
        } catch {
            print("Failed to fetch image:", error)
        }
    }
}
#Playground {
    let person = PersonImage()
}
