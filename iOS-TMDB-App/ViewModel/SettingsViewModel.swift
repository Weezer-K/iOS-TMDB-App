//
//  SettingsViewModel.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/28/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private var likedMovies = Store.sharedMovies
    
    func resetFavorites() {
        likedMovies.overWriteMovies(movies: [])
    }
}
