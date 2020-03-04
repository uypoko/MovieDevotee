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
    let posterPhotoDataSubject: PublishSubject<Data> = PublishSubject()
    let titleSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let yearSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let ratedSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let lengthSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let releaseDateSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let genresSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let directorSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    let writerSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let castSubject: BehaviorSubject<[String]> = BehaviorSubject(value: [])
    let plotSubject: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    let activityIndicatorAnimating: BehaviorSubject<Bool> = BehaviorSubject(value: true)
    
    // MARK: Private properties
    private let movieId: String
    private let movieRepository: MovieRepository
    private let dataRepository: DataRepository
    
    private let disposeBag = DisposeBag()
    
    init(movieId: String, movieRepository: MovieRepository, dataRepository: DataRepository) {
        self.movieId = movieId
        self.movieRepository = movieRepository
        self.dataRepository = dataRepository
        
        getMovie()
    }
    
    private func getMovie() {
        movieRepository.getDetailedMovie(by: movieId)
        //.subscribeOn()
            .subscribe(
                onSuccess: { [weak self] movie in
                    guard let self = self else { return }
                    
                    self.activityIndicatorAnimating.onNext(false)
                    self.getPosterPhotoData(urlString: movie.posterURLString)
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
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func getPosterPhotoData(urlString: String) {
        activityIndicatorAnimating.onNext(true)
        
        dataRepository.getData(urlString: urlString)
            .subscribe(
                onSuccess: { [weak self]  data in
                    guard let self = self else { return }
                    
                    self.activityIndicatorAnimating.onNext(false)
                    self.posterPhotoDataSubject.onNext(data)
                }
            )
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("Detail ViewModel deinit")
    }
}
