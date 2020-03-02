//
//  HomeViewModel.swift
//  MovieDevotee
//
//  Created by Ryan on 2/26/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModel {
    // MARK: Outputs
    let moviesSubject: BehaviorSubject<[GeneralMovie]> = BehaviorSubject(value: [])
    let errorMessagesSubject: PublishSubject<String> = PublishSubject()
    
    // MARK: Inputs
    let searchedKeywordSubject: PublishSubject<String> = PublishSubject()
    let searchButtonTappedSubject: PublishSubject<Void> = PublishSubject()
    
    // MARK: Private properties
    private let movieRepository: MovieRepository
    private let dataRepository: DataRepository
    private let navigator: SearchNavigationDelegate
    private let utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler
    
    private let disposeBag = DisposeBag()
    
    init(movieRepository: MovieRepository,
         dataRepository: DataRepository,
         navigator: SearchNavigationDelegate,
         utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler) {
        self.movieRepository = movieRepository
        self.dataRepository = dataRepository
        self.navigator = navigator
        self.utilityPrioritizedConcurrentQueue = utilityPrioritizedConcurrentQueue
        
        performSearchRequestOnEditing()
        performSearchRequestOnButtonTapped()
    }
    /*
    func getMovieStream() -> Observable<[GeneralMovie]> {
        return searchedKeywordSubject
        .debounce(RxTimeInterval.milliseconds(2000), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .flatMapLatest { keyword in
            return self.movieRepository.searchForMovies(by: keyword)
        }
        .flatMapLatest { movieList in
            Observable.from(movieList)
                .concatMap { movie in
                    return self.dataRepository.getData(urlString: movie.posterURLString)
                        .map { (data: Data) in
                            movie.photoData = data
                            return 1
                        }
                }
                .buffer(timeSpan: 4, count: 2, scheduler: MainScheduler.instance)
                .map { (what: [Int]) in
                    // return modified list of movie for ui update
                    print(movieList.map {$0.id})
                    return movieList
                }
        }
    }
    */
    
    private func performSearchRequestOnEditing() {
        // Observe current search text
        searchedKeywordSubject
            .filter { $0 != "" }
            .debounce(RxTimeInterval.milliseconds(1500), scheduler: MainScheduler.instance)
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
    
    private func search(by keyword: String) {
        movieRepository.searchForMovies(by: keyword)
            .subscribe(
                onSuccess: { [weak self] movies in
                    guard let self = self else { return }
                    
                    self.moviesSubject.onNext(movies)
                    //self.getDataForPhotos(movies: movies)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    self.errorMessagesSubject.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    /*
    private func getDataForPhotos(movies: [GeneralMovie]) {
        for (index, movie) in movies.enumerated() {
            dataRepository.getData(urlString: movie.posterURLString)
                .subscribe(
                    onSuccess: { [weak self] data in
                        guard let self = self else { return }
                        movies[index].photoData = data
                        self.moviesSubject.onNext(movies)
                    }
                )
                .disposed(by: disposeBag)
            
        }
    }
    */
    
    // MARK: Public functions
    
    func goToMovieDetail(movieId: String) {
        navigator.pushToMovieDetail(movieId: movieId)
    }
    
}
