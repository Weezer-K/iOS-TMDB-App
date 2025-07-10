//
//  test.swift
//  iOS-TMDB-APP
//
//  Created by Boba Fett on 6/13/25.
//

import Foundation
import UIKit

struct Show: Codable {
    let id: Int
    let title: String
    let releaseDate: String
}

func decodeShow() {
    let json = """
    {
        "id": 123,
        "title": "Inception",
        "release_date": "2010-07-16"
    }
    """
    
    if let data = json.data(using: .utf8) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if let show = try? decoder.decode(Show.self, from: data) {
            print(show)
        }
    }
}


func downloadImage(url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else {
        throw(URLError(.badServerResponse))
    }
    return image
}

var greet: (String, Int) -> String = { name, age in
    return name + " is \(age) years old"
}
