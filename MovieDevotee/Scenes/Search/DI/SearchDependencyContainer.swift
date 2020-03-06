//
//  HomeDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit

class SearchDependencyContainer {
    private let appDependencyContainer: AppDependencyContainer
    let navigationController = UINavigationController()
    
    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func constructSearchVC() -> UIViewController {
        let recentlyViewedRepository = RecentlyViewedMoviesRepositoryImp(dataStore: appDependencyContainer.movieDataStore)
        
        let movieRemoteAPI = MovieRemoteAPI()
        let movieRepository = MovieRepositoryImp(movieRemoteAPI: movieRemoteAPI)
        
        let searchViewModel = SearchViewModel(
            movieRepository: movieRepository,
            recentlyViewedMoviesRepository: recentlyViewedRepository,
            navigator: self,
            utilityPrioritizedConcurrentQueue: appDependencyContainer.utilityPrioritizedConcurrentQueue)
        let homeViewController = SearchViewController(viewModel: searchViewModel)
        
        navigationController.viewControllers = [homeViewController]
        return navigationController
    }
}

extension SearchDependencyContainer: SearchNavigationDelegate {
    func pushToMovieDetail(movieId: String) {
        let movieDetailContainer = MovieDetailDependencyContainer(appDependencyContainer: appDependencyContainer)
        let movieDetailVC = movieDetailContainer.constructMovieDetailVC(movieId: movieId)
        
        navigationController.pushViewController(movieDetailVC, animated: true)
        
    }
    
}
