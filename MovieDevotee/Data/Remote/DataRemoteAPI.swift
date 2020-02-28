//
//  DataRemoteAPI.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift
import Alamofire

class DataRemoteAPI {
    
    func fetchData(urlString: String) -> Single<Data> {
        return Single.create { single in
            let disposables = Disposables.create()
            
            AF.request(urlString).responseData { response in
                switch response.result {
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return disposables
        }
    }
}
