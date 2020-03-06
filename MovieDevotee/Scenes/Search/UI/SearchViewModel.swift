//
//  HomeViewModel.swift
//  MovieDevotee
//
//  Created by Ryan on 2/26/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel {
    // MARK: Outputs
    let moviesSubject: BehaviorSubject<[GeneralMovie]> = BehaviorSubject(value: [])
    let errorMessagesSubject: PublishSubject<String> = PublishSubject()
    let activityIndicatorAnimating: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    // MARK: Inputs
    let searchedKeywordSubject: PublishRelay<String> = PublishRelay()
    let searchButtonTappedSubject: PublishRelay<Void> = PublishRelay()
    let movieCellTappedSubject: PublishRelay<GeneralMovie> = PublishRelay()
    
    // MARK: Private properties
    private let movieRepository: MovieRepository
    private let recentlyViewedMoviesRepository: RecentlyViewedMoviesRepository
    private let navigator: SearchNavigationDelegate
    private let utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler
    
    private let disposeBag = DisposeBag()
    
    init(movieRepository: MovieRepository,
         recentlyViewedMoviesRepository: RecentlyViewedMoviesRepository,
         navigator: SearchNavigationDelegate,
         utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler) {
        self.movieRepository = movieRepository
        self.recentlyViewedMoviesRepository = recentlyViewedMoviesRepository
        self.navigator = navigator
        self.utilityPrioritizedConcurrentQueue = utilityPrioritizedConcurrentQueue
        
        performSearchRequestOnEditing()
        performSearchRequestOnButtonTapped()
        respondToMovieCellTapped()
    }
    
    private func performSearchRequestOnEditing() {
        // Observe current search text
        searchedKeywordSubject
            .filter { $0 != "" }
            .debounce(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribeOn(utilityPrioritizedConcurrentQueue)
            .subscribe(
                onNext: { [weak self] text in
                    guard let self = self else { return }
                    
                    self.search(by: text)
                })
            .disposed(by: disposeBag)
        
    }
    
    private func performSearchRequestOnButtonTapped() {
        let filteredSearchButtonTappedSubject = searchButtonTappedSubject
            .throttle(RxTimeInterval.milliseconds(1000), latest: true, scheduler: MainScheduler.instance)
        
        searchedKeywordSubject
            .filter { $0 != "" }
            .sample(filteredSearchButtonTappedSubject)
            .subscribeOn(utilityPrioritizedConcurrentQueue)
            .subscribe(
                onNext: { [weak self] text in
                    guard let self = self else { return }
                    
                    self.search(by: text)
                })
            .disposed(by: disposeBag)
    }
    
    private func respondToMovieCellTapped() {
        movieCellTappedSubject
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  movie in
                guard let self = self else { return }
                
                self.recentlyViewedMoviesRepository.saveMovieToRecentlyViewed(movie: movie)
                self.navigator.pushToMovieDetail(movieId: movie.id)
            })
            .disposed(by: disposeBag)
    }
    
    private func search(by keyword: String) {
        activityIndicatorAnimating.onNext(true)
        
        movieRepository.searchForMovies(by: keyword)
            .subscribe(
                onSuccess: { [weak self] movies in
                    guard let self = self else { return }
                    
                    self.activityIndicatorAnimating.onNext(false)
                    self.moviesSubject.onNext(movies)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    self.activityIndicatorAnimating.onNext(false)
                    self.errorMessagesSubject.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
}
