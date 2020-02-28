//
//  MovieSearchHistoryRepository.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift

protocol RecentlyViewedMoviesRepository {
    func readRecentlyViewedMoviesHistory() -> Single<[GeneralMovie]>
    func saveMovieToRecentlyViewed(movie: GeneralMovie) -> Completable
}
