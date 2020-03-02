//
//  HomeDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation

class SearchDependencyContainer {
    private let appDependencyContainer: AppDependencyContainer
    
    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func constructSearchVC() -> SearchViewController {
        let movieRemoteAPI = MovieRemoteAPI()
        let movieRepository = MovieRepositoryImp(movieRemoteAPI: movieRemoteAPI)
        
        let dataRemoteAPI = DataRemoteAPI()
        let dataRepository = DataRepositoryImp(dataRemoteAPI: dataRemoteAPI)
        
        let searchViewModel = SearchViewModel(
            movieRepository: movieRepository,
            dataRepository: dataRepository,
            navigator: self,
            utilityPrioritizedConcurrentQueue: appDependencyContainer.utilityPrioritizedConcurrentQueue)
        let homeViewController = SearchViewController(viewModel: searchViewModel)
        
        return homeViewController
    }
}

extension SearchDependencyContainer: SearchNavigationDelegate {
    func pushToMovieDetail(movieId: String) {
        let movieDetailContainer = MovieDetailDependencyContainer(appDependencyContainer: appDependencyContainer)
        let movieDetailVC = movieDetailContainer.constructMovieDetailVC(movieId: movieId)
        
        appDependencyContainer.navigationController.pushViewController(movieDetailVC, animated: false)
        
    }
    
}
