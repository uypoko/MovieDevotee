//
//  Movie.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//
import Foundation
import RealmSwift

@objcMembers class GeneralMovie: Object {
    enum MovieType: String {
        case movie
        case series
        case episode
    }
    
    dynamic var id: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var type: MovieType = .movie
    dynamic var year: String = ""
    dynamic var posterURLString: String = ""
    
}
