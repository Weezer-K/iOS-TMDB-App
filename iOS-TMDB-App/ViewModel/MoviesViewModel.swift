//
//  MoviesViewModel.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//


import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movieList: [Movie] = []
    @Published var isDay = true
    @Published var mostPopularString = "Today"
    @Published var noMorePages = false
    @Published var selectedId = 0
    @Published var errorMessage: String? = nil

    var currentPage = 1
    private let service: Service = Store.shared

    func getMovies() {
        service.getMovies(isDay: isDay, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.movieList += response.results
                if response.page < response.totalPages {
                    self.currentPage += 1
                } else {
                    self.noMorePages = true
                }
                self.errorMessage = nil

            case .failure(let error):
                self.errorMessage = "Something went wrong: \(error.descritipion)"
            }
        }
    }

    func dayPressed() {
        if !isDay {
            isDay.toggle()
            mostPopularString = "Today"
            movieList = []
            currentPage = 1
            getMovies()
        }
    }

    func weekPressed() {
        if isDay {
            isDay.toggle()
            mostPopularString = "This Week"
            movieList = []
            currentPage = 1
            getMovies()
        }
    }
}
