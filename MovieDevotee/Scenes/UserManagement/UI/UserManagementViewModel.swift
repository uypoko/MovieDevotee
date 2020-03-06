//
//  UserManagementViewModel.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class UserManagementViewModel {
    
    // MARK: Outputs
    let recentlyViewedMovies: Results<GeneralMovie>
    // MARK: Inputs
    let movieCellTapped: PublishSubject<GeneralMovie> = PublishSubject()
    
    private let utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler
    private let navigator: UserManagementNavigator
    private let recentlyViewedMoviesRepository: RecentlyViewedMoviesRepository
    
    private let disposeBag = DisposeBag()
    
    init(utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler,
         navigator: UserManagementNavigator,
         recentlyViewedMoviesRepository: RecentlyViewedMoviesRepository) {
        self.utilityPrioritizedConcurrentQueue = utilityPrioritizedConcurrentQueue
        self.navigator = navigator
        self.recentlyViewedMoviesRepository = recentlyViewedMoviesRepository
        self.recentlyViewedMovies =  recentlyViewedMoviesRepository.readRecentlyViewedMoviesHistory()
        
        respondToMovieCellTapped()
    }
    
    private func respondToMovieCellTapped() {
        movieCellTapped
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] movie in
                    guard let self = self else { return }
                    
                    self.recentlyViewedMoviesRepository.saveMovieToRecentlyViewed(movie: movie)
                    self.navigator.goToMovieDetail(movie: movie)
                }
            )
            .disposed(by: disposeBag)
        
    }
    
}
