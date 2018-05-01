//
//  MoviesController.swift
//  MovieSearch
//
//  Created by Michael Duong on 2/2/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation
import UIKit

class MoviesController {
    
    static let shared = MoviesController()
    
    let baseURL = "https://api.themoviedb.org/3/search/movie?api_key="
    
    private let APIKey = "c33253faf7c49b0fe479be705dbe9b0d"
    
    let queryParam = "&query="
    
    var results: [Movie] = []
    
    func fetchMovies(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        
        let urlCombined = baseURL + APIKey + queryParam + searchTerm
  
        guard let url = URL(string: urlCombined) else {
            print("Error: invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error fetching movies \(error) \(error.localizedDescription)")
                completion([]); return
            }
            
            guard let data = data else {
                print("Error no data")
                completion([]); return
            }
            
            do {
                let results = try JSONDecoder().decode(MovieArray.self, from: data).results
                self.results = results
                completion(results)
            } catch let error {
                print("Error decoding data \(error) \(error.localizedDescription)")
                }
            }.resume()
    }
    
    func fetchThumbnail(posterPath: String, completion: @escaping (UIImage?) -> Void) {
        
        let baseURL = "http://image.tmdb.org/t/p/w500/"
        
        let urlCombined = baseURL + posterPath
        print(urlCombined)
        
        guard let url = URL(string: urlCombined) else {
            print("Error: invalid thumbnail URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error fetching thumbnail \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            
            guard let data = data else {
                print("Error: no data")
                completion(nil); return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
