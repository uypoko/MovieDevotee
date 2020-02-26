//
//  MovieRemoteAPI.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxSwift

class MovieRemoteAPI {
    
    let apiKey = "77dd85e9"
    let baseURLString = "http://www.omdbapi.com"
    
    func fetchMovies(for keyword: String) -> Single<[Movie]> {
        return Single.create { [weak self] single in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            let params = ["apikey": self.apiKey, "s": keyword]
            print("params \(params)")
            
            AF.request(self.baseURLString, parameters: params)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let originalJson = JSON(data)
                        let arrayJson = originalJson["Search"].arrayValue
                        //debugPrint(arrayJson)
                        
                        var movies: [Movie] = []
                        for movieJson in arrayJson {
                            let id = movieJson["imdbID"].stringValue
                            let title = movieJson["Title"].stringValue
                            let type = movieJson["Type"].stringValue
                            let posterURL = movieJson["Poster"].stringValue
                            let year = movieJson["Year"].stringValue
                            
                            let movie = Movie()
                            movie.id = id
                            movie.title = title
                            movie.type = Movie.MovieType(rawValue: type) ?? .movie
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
}
