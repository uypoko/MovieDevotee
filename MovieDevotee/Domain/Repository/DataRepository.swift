//
//  DataRepository.swift
//  MovieDevotee
//
//  Created by Ryan on 2/27/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift

protocol DataRepository {
    func getData(urlString: String) -> Single<Data>
}
