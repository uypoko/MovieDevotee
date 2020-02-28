//
//  MovieRepositoryImp.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift

class MovieRepositoryImp: MovieRepository {
    
    private let movieRemoteAPI: MovieRemoteAPI
    
    init(movieRemoteAPI: MovieRemoteAPI) {
        self.movieRemoteAPI = movieRemoteAPI
    }
    
    func searchForMovies(by keyword: String) -> Single<[GeneralMovie]> {
        return movieRemoteAPI.fetchMovies(by: keyword)
    }
    
    func getDetailedMovie(by id: String) -> Single<DetailedMovie> {
        return movieRemoteAPI.fetchDetailMovie(by: id)
    }
    
}
