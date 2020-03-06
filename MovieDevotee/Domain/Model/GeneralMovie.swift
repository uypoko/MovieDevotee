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
    
    enum Properties: String {
        case id
        case title
        case type
        case year
        case posterURLString
        case viewedDate
    }
    
    dynamic var id: String = UUID().uuidString
    dynamic var title: String = ""
    dynamic var _type: String = MovieType.movie.rawValue
    
    dynamic var year: String = ""
    dynamic var posterURLString: String = ""
    dynamic var viewedDate: Date = Date(timeIntervalSince1970: 0)
    
    override class func primaryKey() -> String? {
        return Properties.id.rawValue
    }
    
    // MARK: In-Memory
    var type: MovieType {
        get { return MovieType(rawValue: _type)! }
        set { _type = newValue.rawValue }
    }
}
