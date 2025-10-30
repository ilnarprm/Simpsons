//
//  Network.swift
//  Simpsons
//
//  Created by Ilnar on 16.10.2025.
//

import Foundation


final class Network {
    let baseUrl = "https://thesimpsonsapi.com"

    // Новый async/await-метод
    func sendRequest(page: Int) async throws -> Pages {
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = "/api/characters"
        urlComponents?.queryItems = [URLQueryItem(name: "page", value: "\(page)")]

        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let networkResult = try JSONDecoder().decode(Pages.self, from: data)
        return networkResult
    }
}
