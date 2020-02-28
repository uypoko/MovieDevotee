//
//  HomeViewModel.swift
//  MovieDevotee
//
//  Created by Ryan on 2/26/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    // MARK: Outputs
    let moviesSubject: BehaviorSubject<[GeneralMovie]> = BehaviorSubject(value: [])
    let errorMessagesSubject: PublishSubject<String> = PublishSubject()
    
    // MARK: Inputs
    let searchedKeywordsSubject: PublishSubject<String> = PublishSubject()
    
    // MARK: Private properties
    private let movieRepository: MovieRepository
    private let dataRepository: DataRepository
    
    private let disposeBag = DisposeBag()
    
    init(movieRepository: MovieRepository, dataRepository: DataRepository) {
        self.movieRepository = movieRepository
        self.dataRepository = dataRepository
        // Sample data
        let movie1 = GeneralMovie()
        movie1.title = "abc"
        movie1.year = "2019"
        let movie2 = GeneralMovie()
        movie2.title = "abc"
        movie2.year = "2019"
        let movie3 = GeneralMovie()
        movie3.title = "abc"
        movie3.year = "2019"
        moviesSubject.onNext([movie1, movie2, movie3])
        
        performSearchRequestOnEditing()
    }
    
    private func performSearchRequestOnEditing() {
        // Observe current search text
        searchedKeywordsSubject
            .throttle(1, scheduler: MainScheduler.instance)
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
                    self.getDataForPhotos(movies: movies)
                },
                onError: { [weak self] error in
                    guard let self = self else { return }
                    
                    self.errorMessagesSubject.onNext(error.localizedDescription)
                }
            )
            .disposed(by: disposeBag)
    }
    
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
    
}
