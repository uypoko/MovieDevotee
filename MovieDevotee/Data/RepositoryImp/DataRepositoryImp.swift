//
//  DataRepositoryImp.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift

class DataRepositoryImp: DataRepository {
    
    private let dataRemoteAPI: DataRemoteAPI
    
    init(dataRemoteAPI: DataRemoteAPI) {
        self.dataRemoteAPI = dataRemoteAPI
    }
    
    func getData(urlString: String) -> Single<Data> {
        return dataRemoteAPI.fetchData(urlString: urlString)
    }
    
}
