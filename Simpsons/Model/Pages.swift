//
//  Pages.swift
//  Simpsons
//
//  Created by Ilnar on 17.10.2025.
//

import Foundation


struct Pages: Decodable {
    var next: String? = nil
    var pages: Int = 1
    var results: [Persons] = []

    struct Persons: Decodable {
        var id: Int
        var age: Int? = nil
        var birthdate: String? = nil
        var gender: String
        var name: String
        var occupation: String? = nil
        var portraitPath: String
        var phrases: [String]? = []
        var status: String? = nil

        enum CodingKeys: String, CodingKey {
            case id
            case age
            case birthdate
            case gender
            case name
            case occupation
            case portraitPath = "portrait_path"
            case phrases
            case status
        }
    }
}
