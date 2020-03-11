//
//  DetailedMovie.swift
//  MovieDevotee
//
//  Created by Ryan on 2/28/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//
/*
 "Title": "The Social Network",
 "Year": "2010",
 "Rated": "PG-13",
 "Released": "01 Oct 2010",
 "Runtime": "120 min",
 "Genre": "Biography, Drama",
 "Director": "David Fincher",
 "Writer": "Aaron Sorkin (screenplay), Ben Mezrich (book)",
 "Actors": "Jesse Eisenberg, Rooney Mara, Bryan Barter, Dustin Fitzsimons",
 "Plot": "As Harvard student Mark Zuckerberg creates the social networking site that would become known as Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later squeezed out of the business.",
 "Language": "English, French",
 "Country": "USA",
 "Awards": "Won 3 Oscars. Another 169 wins & 179 nominations.",
 "Poster": "https://m.media-amazon.com/images/M/MV5BOGUyZDUxZjEtMmIzMC00MzlmLTg4MGItZWJmMzBhZjE0Mjc1XkEyXkFqcGdeQXVyMTM
 */
import Foundation

struct DetailedMovie: Codable {
    
    struct Ratings: Codable {
        enum SourceType: String {
            case imdb = "Internet Movie Database"
            case rotten = "Rotten Tomatoes"
            case meta = "Metacritic"
        }
        
        enum CodingKeys: String, CodingKey {
            case _source = "Source"
            case value = "Value"
        }
        
        let _source: String
        let value: String
        var source: SourceType {
            return SourceType(rawValue: _source) ?? .imdb
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case length = "Runtime"
        case releasedDate = "Released"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case posterURLString = "Poster"
        case cast = "Actors"
        case plot = "Plot"
        case ratings = "Ratings"
    }
    
    let id: String
    let title: String
    let year: String
    let rated: String
    let length: String
    let releasedDate: String
    let genre: [String]
    let director: String
    let writer: [String]
    let posterURLString: String
    let cast: [String]
    let plot: String
    let ratings: [Ratings]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: CodingKeys.id)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        year = try values.decode(String.self, forKey: CodingKeys.year)
        rated = try values.decode(String.self, forKey: CodingKeys.rated)
        length = try values.decode(String.self, forKey: CodingKeys.length)
        releasedDate = try values.decode(String.self, forKey: CodingKeys.releasedDate)
        let genreString = try values.decode(String.self, forKey: CodingKeys.genre)
        genre = genreString.components(separatedBy: ", ")
        director = try values.decode(String.self, forKey: CodingKeys.director)
        let writerString = try values.decode(String.self, forKey: CodingKeys.writer)
        writer = writerString.components(separatedBy: ", ")
        posterURLString = try values.decode(String.self, forKey: CodingKeys.posterURLString)
        let castString = try values.decode(String.self, forKey: CodingKeys.cast)
        cast = castString.components(separatedBy: ", ")
        plot = try values.decode(String.self, forKey: CodingKeys.plot)
        ratings = try values.decode([Ratings].self, forKey: CodingKeys.ratings)
    }
    
}
