//
//  PopularMoviesViewModel.swift
//  Popular Movies
//
//  Created by Berkay Demir on 24.08.2024.
//

import Foundation

class PopularMoviesViewModel {
    private let service = ApiService()
    
    var popularMovies = [Movie]()
    var errorMessage = ""
    
    func getPopularMovies(completion : @escaping () -> ()) {
        service.getPopularMovies { [weak self] result in
            switch result {
                case .success(let listOfMovies) :
                    self?.popularMovies = listOfMovies.movies
                    completion()
                    
                case .failure(let error) :
                    self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        if popularMovies.count != 0{
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath : IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
