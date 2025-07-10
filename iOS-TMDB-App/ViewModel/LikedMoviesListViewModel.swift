//
//  LikedMoviesListViewModel.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import Foundation

class LikedMoviesListViewModel: ObservableObject {
    private var likedMovies = Store.sharedMovies
    @Published var movies: [Movie] = []
    let basePicUrl = "https://image.tmdb.org/t/p//w300"
    
    init() {
        likedMovies.loadMovies()
        self.movies = likedMovies.movies
    }
    
    func getMovies() {
        likedMovies.loadMovies()
        movies = likedMovies.movies
    }
    
    func removeMovies(id: Int) {
        let index = movies.firstIndex(where: {$0.id == id})
        guard let firstIndex = index else {
            return
        }
        movies.remove(at: firstIndex)
        saveMovies()
    }
    
    func saveMovies() {
        likedMovies.overWriteMovies(movies: movies)
    }
}
