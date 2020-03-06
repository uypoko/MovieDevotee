//
//  UserManagementContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import UIKit

class UserManagementContainer {
    private let appDependencyContainer: AppDependencyContainer
    let navigationController = UINavigationController()

    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func constructUserManagementVC() -> UIViewController {
        let recentlyViewedRepository = RecentlyViewedMoviesRepositoryImp(dataStore: appDependencyContainer.movieDataStore)
        
        let viewModel = UserManagementViewModel(
            utilityPrioritizedConcurrentQueue: appDependencyContainer.utilityPrioritizedConcurrentQueue,
            navigator: self,
            recentlyViewedMoviesRepository: recentlyViewedRepository)
        
        let userViewController = UserManagementViewController(viewModel: viewModel)
        navigationController.viewControllers = [userViewController]
        
        return navigationController
    }
}

extension UserManagementContainer: UserManagementNavigator {
    func goToMovieDetail(movie: GeneralMovie) {
        let movieDetailContainer = MovieDetailDependencyContainer(appDependencyContainer: appDependencyContainer)
        let movieDetailVC = movieDetailContainer.constructMovieDetailVC(movieId: movie.id)
        
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
