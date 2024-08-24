//
//  ApiService.swift
//  Popular Movies
//
//  Created by Berkay Demir on 24.08.2024.
//

import Foundation

class ApiService {
    private let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
    
    func getPopularMovies(completion : @escaping (Result<MoviesData , Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data , response , error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
