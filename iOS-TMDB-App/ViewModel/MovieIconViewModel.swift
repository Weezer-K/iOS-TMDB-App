//
//  MovieIconViewModel.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import Foundation

class MovieIconViewModel: ObservableObject {
    @Published var isLiked: Bool = false
    @Published var imageURL: URL?
    @Published var movie: Movie
    @Published var isButtonDisabled: Bool = false
    private var likedMovies = Store.sharedMovies

    init(movie: Movie, _isButtonDisabled: Bool = false) {
        let urlPath = ("https://image.tmdb.org/t/p/w300" + (movie.posterPath ?? ""))
        self.imageURL = URL(string: urlPath)
        self.movie = movie
        self.isLiked = likedMovies.isMovieLiked(movie: movie)
        self.isButtonDisabled = _isButtonDisabled
    }

    func toggleLike() {
        isLiked.toggle()
        isLiked ? addToLikedList() : removeFromLikedList()
    }
    
    func removeFromLikedList() {
        likedMovies.removeMovie(movie: self.movie)
    }
    
    func disableButton() {
        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isButtonDisabled = false
        }
    }
    
    func addToLikedList() {
        likedMovies.addMovie(movie: self.movie)
    }
    
    func checkIfIsLiked() {
        likedMovies.loadMovies()
        if likedMovies.isMovieLiked(movie: movie) != isLiked {
            isLiked.toggle()
        }
    }
}
