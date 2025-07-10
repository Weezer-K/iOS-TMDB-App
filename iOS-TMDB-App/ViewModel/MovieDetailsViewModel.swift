//
//  MovieDetailsViewModel.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    @Published var overview: String = ""
    @Published var title: String = ""
    @Published var runTime: Int = 0
    @Published var releaseDate: String = ""
    @Published var movie: Movie?
    @Published var genres: [Genre]?
    let service: Store = Store.shared

    init(id: Int) {
        getMovieDetails(id: id)
    }
    
    func getMovieDetails(id: Int) {
        service.getMovie(id: id){ [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.movie = response
                self.overview = response.overview
                self.runTime = response.runtime ?? 0
                self.releaseDate = response.releaseDate ?? ""
                self.title = response.title
                self.genres = response.genres
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
