//
//  SearchResult.swift
//  MovieDevotee
//
//  Created by Ryan on 3/11/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let movies: [GeneralMovie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}
