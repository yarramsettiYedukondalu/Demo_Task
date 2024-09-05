//
//  MovieService.swift
//  Demo_Task
//
//  Created by ToqSoft on 06/09/24.
//

import Foundation
class MovieService {
    static let shared = MovieService()
    
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=5f84c015&s=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            do {
                let result = try JSONDecoder().decode(MovieListResponse.self, from: data)
                if result.Response == "False" {
                    completion(.failure(NSError(domain: result.Error ?? "Unknown API error", code: -1, userInfo: nil)))
                    return
                }
                completion(.success(result.Search))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
