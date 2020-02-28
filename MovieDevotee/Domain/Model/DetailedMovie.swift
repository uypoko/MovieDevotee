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

struct DetailedMovie {
    let id: String
    let title: String
    let year: String
    let rated: String
    let length: String
    let genre: [String]
    let director: String
    let posterURLString: String
    let cast: [String]
    let plot: String
    
    static let empty = DetailedMovie(id: "", title: "", year: "", rated: "", length: "", genre: [], director: "", posterURLString: "", cast: [], plot: "")
}
