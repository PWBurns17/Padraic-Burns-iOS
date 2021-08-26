//
//  MovieViewModel.swift
//  Movies
//
//  Created by Field Employee on 24/08/2021.
//

import Foundation
class MovieViewModel {
    
    init (){}
    // MARK:- internal properties
    var movieBinding: (() -> Void)?
    var count: Int { movies.count }
    
    func getTitle (at row: Int) -> String { movies[row].originalTitle }
    func getOverview (at row: Int) -> String { movies[row].overview }
    
    // MARK:- private properties
    private let networkManager = NetworkManager()
    var movies = [Movie]()
    
    // MARK:- internal properties
    func fetchMovies() {
        // create the url
        let urlS = "https://api.themoviedb.org/3/movie/550?api_key=a53510055c2f6a1d5b665c62a0dccfcb"
        
        networkManager.getMovies(from: urlS) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.movieBinding?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
