//
//  RecentlyViewedMoviesRepositoryImp.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RecentlyViewedMoviesRepositoryImp: RecentlyViewedMoviesRepository {
    
    private let dataStore: MovieDataStore
    
    private let disposeBag = DisposeBag()
    
    init(dataStore: MovieDataStore) {
        self.dataStore = dataStore
    }
    
    func readRecentlyViewedMoviesHistory() -> Results<GeneralMovie> {
        return dataStore.fetchRecentlyViewedMovies()
    }
    
    func saveMovieToRecentlyViewed(movie: GeneralMovie) {
        dataStore.saveMovieToRecetlyViewed(movie: movie)
            .subscribe(
                onCompleted: {
                    print("did save recently viewed movie: \(movie.title)")
                },
                onError: { error in
                    print(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
}
