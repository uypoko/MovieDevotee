//
//  MovieDetailDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/28/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation

class MovieDetailDependencyContainer {
    private let appDependencyContainer: AppDependencyContainer

    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func constructMovieDetailVC(movieId: String) -> MovieDetailViewController {
        let movieRemoteAPI = MovieRemoteAPI()
        let movieRepository = MovieRepositoryImp(movieRemoteAPI: movieRemoteAPI)
        
        let dataRemoteAPI = DataRemoteAPI()
        let dataRepository = DataRepositoryImp(dataRemoteAPI: dataRemoteAPI)
        
        let movieDetailViewModel = MovieDetailViewModel(
            movieId: movieId,
            movieRepository: movieRepository,
            dataRepository: dataRepository,
            utilityPrioritizedConcurrentQueue: appDependencyContainer.utilityPrioritizedConcurrentQueue)
        
        let movieDetailVC = MovieDetailViewController(viewModel: movieDetailViewModel)
        
        return movieDetailVC
    }
}
