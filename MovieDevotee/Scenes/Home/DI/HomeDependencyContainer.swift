//
//  HomeDependencyContainer.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation

class HomeDependencyContainer {
    private let appDependencyContainer: AppDependencyContainer
    
    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }
    
    func constructHomeVC() -> HomeViewController {
        let movieRemoteAPI = MovieRemoteAPI()
        let movieRepository = MovieRepositoryImp(movieRemoteAPI: movieRemoteAPI)
        
        let dataRemoteAPI = DataRemoteAPI()
        let dataRepository = DataRepositoryImp(dataRemoteAPI: dataRemoteAPI)
        let homeViewModel = HomeViewModel(movieRepository: movieRepository, dataRepository: dataRepository)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        return homeViewController
    }
}
