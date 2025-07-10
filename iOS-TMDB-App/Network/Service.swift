//
//  Service.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import Foundation


protocol Service {
    func getMovies(isDay: Bool, page: Int, onCompletion: @escaping (Result<MovieList, MovieError>) -> ())
    func getMovie(id: Int, onCompletion: @escaping (Result<Movie, MovieError>) -> ())
}

enum MovieError: Error, CustomNSError {
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    case apiError
    
    var descritipion: String {
        switch self {
        case .apiError: 
            "Failed to get data"
        case .invalidEndpoint:
            "Invalid Endpoint"
        case .invalidResponse:
            "Please check if your Wifi/cellular data is on"
        case .noData:
            "No data was found"
        case .serializationError:
            "Serialization Error"
        }
    }
    
    var errorInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}


