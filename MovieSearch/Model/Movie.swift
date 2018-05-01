//
//  Movie.swift
//  MovieSearch
//
//  Created by Michael Duong on 2/2/18.
//  Copyright © 2018 Turnt Labs. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    
    var title: String
    var poster_path: String?
    var overview: String
    var vote_average: Double?
    
}

struct MovieArray: Decodable {

    let results: [Movie]
}

