//
//  MovieRemoteAPI.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import Alamofire
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
                .responseDecodable(of: SearchResult.self) { response in
                    switch response.result {
                    case .success(let result):
                        single(.success(result.movies))
                    case .failure(let error):
                        print(error)
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
                .responseDecodable(of: DetailedMovie.self) { response in
                    switch response.result {
                    case .success(let result):
                        single(.success(result))
                    case .failure(let error):
                        print(error)
                        single(.error(error))
                    }
            }
            
            return disposables
        }
    }
    
}
