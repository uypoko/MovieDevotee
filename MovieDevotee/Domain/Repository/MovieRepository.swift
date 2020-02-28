//
//  MovieRepository.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieRepository {
    //func getMovie(by id: String) -> Single<Movie?>
    func searchForMovies(by keyword: String) -> Single<[GeneralMovie]>
    func getDetailedMovie(by id: String) -> Single<DetailedMovie>
}
