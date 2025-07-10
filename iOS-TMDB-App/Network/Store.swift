//
//  Store.swift
//  iOS-TMDB-APP
//
//  Created by Kyle Peters on 5/27/25.
//

import Foundation

class Store: Service {
    
    static let shared = Store()
    static let sharedMovies = LikedMovies()
    
    private init() {}
    
    private let apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    private let urlSession = URLSession.shared
    private let baseUrl = "https://api.themoviedb.org/3"
    
    //https://api.themoviedb.org/3/trending/movie/day
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    
    func getMovies(isDay: Bool, page: Int = 1, onCompletion: @escaping (Result<MovieList, MovieError>) -> ()) {
        let dayOrWeek = (isDay ? "day" : "week")
        let urlString = baseUrl + "/trending/movie/"+dayOrWeek
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(.invalidEndpoint))
            return
        }
        
        let parameters: [String: String] = [
                "page": "\(page)"
            ]
        
        self.apiCall(url: url, parameters: parameters, onCompletion: onCompletion)
    }
    
    func getMovie(id: Int, onCompletion: @escaping (Result<Movie, MovieError>) -> ()) {
        let urlString = baseUrl + "/movie/\(id)"
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(.invalidEndpoint))
            return
        }
        
        self.apiCall(url: url, onCompletion: onCompletion)
    }
    
    func apiCall<D: Decodable>(url: URL,
                               parameters: [String: String]? = nil,
                               onCompletion: @escaping(Result<D, MovieError>) -> ()) {
        
        var items = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = parameters {
            items.append(contentsOf: params.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        guard var componentes = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            onCompletion(.failure(.invalidEndpoint))
            return
        }
        
        componentes.queryItems = items
        
        guard let callURL = componentes.url else {
            onCompletion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: callURL) { [weak self] (data, response, error) in
            guard let self = self else {return }
            if (error != nil) {
                onCompletion(.failure(.apiError))
            }
            
            guard let httpResp = response as? HTTPURLResponse, 200..<300 ~= httpResp.statusCode else {
                self.onCompletetionHandler(response: .failure(.invalidResponse), onCompletion: onCompletion)
                return
            }
            
            guard let data = data else {
                self.onCompletetionHandler(response: .failure(.noData), onCompletion: onCompletion)
                return
            }
            
            do {
                let decoded = try Store.jsonDecoder.decode(D.self, from: data)
                self.onCompletetionHandler(response: .success(decoded), onCompletion: onCompletion)
            } catch {
                self.onCompletetionHandler(response: .failure(.serializationError), onCompletion: onCompletion)
            }
        }.resume()
        
    }
    
    func onCompletetionHandler<D: Decodable>(response: Result<D, MovieError>,
                                             onCompletion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            onCompletion(response)
        }
    }
    
}
