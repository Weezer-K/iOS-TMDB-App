//
//  LikedMovies.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import Foundation

class LikedMovies {
    
    private let fileName = "Liked Movies.json"
    @Published var movies: [Movie] = []
    
    init() {
        loadMovies()
    }
    
    func addMovie(movie: Movie) {
            movies.append(movie)
            saveMovies()
    }

    func removeMovie(movie: Movie) {
        let index = movies.firstIndex(where: {$0.id == movie.id})
        guard let firstIndex = index else {
            return
        }
        movies.remove(at: firstIndex)
        saveMovies()
    }
    
    func isMovieLiked(movie: Movie) -> Bool {
        let firstIndex = movies.firstIndex(where: {$0.id == movie.id})
        guard firstIndex != nil else {
            return false
        }
        return true
    }
    
    private func getFileURL() -> URL? {
            do {
                let documentDirectory = try FileManager.default.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: false
                )
                return documentDirectory.appendingPathComponent(fileName)
            } catch {
                print("Error getting file URL: \(error)")
                return nil
            }
    }

    func saveMovies() {
            guard let url = getFileURL() else { return }

            do {
                let data = try JSONEncoder().encode(movies)
                try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Failed to save movies: \(error)")
            }
    }
    
    func overWriteMovies(movies: [Movie]) {
        guard let url = getFileURL() else { return }

        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save movies: \(error)")
        }
    }

    func loadMovies() {
            guard let url = getFileURL(),
                  FileManager.default.fileExists(atPath: url.path)
            else {
                movies = []
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                self.movies = movies
            } catch {
                print("Failed to load movies: \(error)")
            }
    }
    
}
