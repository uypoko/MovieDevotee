//
//  MovieRemoteAPI.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class MovieRemoteAPI {
    
    private let apiKey = "77dd85e9"
    private let baseURLString = "http://www.omdbapi.com"
    
    func fetchMovies(by keyword: String) -> Single<[GeneralMovie]> {
        return Single.create { [weak self] single in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            let params = ["apikey": self.apiKey, "s": keyword]
            
            AF.request(self.baseURLString, parameters: params)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let originalJson = JSON(data)
                        let arrayJson = originalJson["Search"].arrayValue
                        //debugPrint(arrayJson)
                        
                        var movies: [GeneralMovie] = []
                        for movieJson in arrayJson {
                            let id = movieJson["imdbID"].stringValue
                            let title = movieJson["Title"].stringValue
                            let type = movieJson["Type"].stringValue
                            let posterURL = movieJson["Poster"].stringValue
                            let year = movieJson["Year"].stringValue
                            
                            let movie = GeneralMovie()
                            movie.id = id
                            movie.title = title
                            movie.type = GeneralMovie.MovieType(rawValue: type) ?? .movie
                            movie.posterURLString = posterURL
                            movie.year = year
                            
                            movies.append(movie)
                        }
                        
                        single(.success(movies))
                    case .failure(let error):
                        single(.error(error))
                    }
                }
            
            return disposables
        }
    }
    
    func fetchDetailMovie(by id: String) -> Single<DetailedMovie> {
        return Single.create { [weak self] single in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            let params = ["apikey": self.apiKey, "i": id]
            
            AF.request(self.baseURLString, parameters: params)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let data):
                        let movieJSON = JSON(data)
                        let title = movieJSON["Title"].stringValue
                        let year = movieJSON["Year"].stringValue
                        let rated = movieJSON["Rated"].stringValue
                        let length = movieJSON["Runtime"].stringValue
                        let genreString = movieJSON["Genre"].stringValue
                        let genreArray = genreString.components(separatedBy: ", ")
                        let director = movieJSON["David Fincher"].stringValue
                        let posterURL = movieJSON["Poster"].stringValue
                        let castString = movieJSON["Actors"].stringValue
                        let castArray = castString.components(separatedBy: ", ")
                        let plot = movieJSON["Plot"].stringValue
                        
                        let movie = DetailedMovie(
                            id: id,
                            title: title,
                            year: year,
                            rated: rated,
                            length: length,
                            genre: genreArray,
                            director: director,
                            posterURLString: posterURL,
                            cast: castArray,
                            plot: plot
                        )
                        
                        single(.success(movie))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            
            return disposables
        }
    }
    
}
