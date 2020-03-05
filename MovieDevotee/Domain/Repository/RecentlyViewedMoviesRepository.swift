//
//  MovieSearchHistoryRepository.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift
import RealmSwift

protocol RecentlyViewedMoviesRepository {
    func readRecentlyViewedMoviesHistory() -> Results<GeneralMovie>
    func saveMovieToRecentlyViewed(movie: GeneralMovie)
}
