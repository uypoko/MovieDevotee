//
//  MovieDetailViewModel.swift
//  MovieDevotee
//
//  Created by Ryan on 2/28/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailViewModel {
    
    // MARK: Outputs
    let posterURLSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let titleSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let yearSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let ratedSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let lengthSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let releaseDateSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let genresSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    
    let imdbRatingSubject: BehaviorSubject<String> = BehaviorSubject(value: "0.0/10")
    let rottenRatingSubject: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    let metaRatingSubject: BehaviorSubject<String?> = BehaviorSubject(value: nil)
    
    let directorSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let writerSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let castSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let plotSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    let activityIndicatorAnimating: BehaviorSubject<Bool> = BehaviorSubject(value: true)
    
    // MARK: Private properties
    private let movieId: String
    private let movieRepository: MovieRepository
    private let dataRepository: DataRepository
    private let utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler
    
    private let disposeBag = DisposeBag()
    
    init(movieId: String,
         movieRepository: MovieRepository,
         dataRepository: DataRepository,
         utilityPrioritizedConcurrentQueue: ConcurrentDispatchQueueScheduler) {
        self.movieId = movieId
        self.movieRepository = movieRepository
        self.dataRepository = dataRepository
        self.utilityPrioritizedConcurrentQueue = utilityPrioritizedConcurrentQueue
        
        getMovie()
    }
    
    private func getMovie() {
        movieRepository.getDetailedMovie(by: movieId)
            .subscribeOn(utilityPrioritizedConcurrentQueue)
            .subscribe(
                onSuccess: { [weak self] movie in
                    guard let self = self else { return }
                    
                    self.activityIndicatorAnimating.onNext(false)
                    self.posterURLSubject.onNext(movie.posterURLString)
                    self.titleSubject.onNext(movie.title)
                    self.yearSubject.onNext(movie.year)
                    self.ratedSubject.onNext(movie.rated)
                    self.lengthSubject.onNext(movie.length)
                    self.releaseDateSubject.onNext(movie.releasedDate)
                    self.genresSubject.onNext(movie.genre)
                    self.directorSubject.onNext(movie.director)
                    self.writerSubject.onNext(movie.writer)
                    self.castSubject.onNext(movie.cast)
                    self.plotSubject.onNext(movie.plot)
                    
                    for rating in movie.ratings {
                        switch rating.source {
                        case .imdb:
                            self.imdbRatingSubject.onNext(rating.value)
                        case .rotten:
                            self.rottenRatingSubject.onNext(rating.value)
                        case .meta:
                            self.metaRatingSubject.onNext(rating.value)
                        }
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
}
