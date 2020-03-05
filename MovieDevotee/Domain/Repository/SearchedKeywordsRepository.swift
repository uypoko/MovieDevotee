//
//  SearchedKeywordRepository.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import RxSwift

protocol SearchedKeywordsRepository {
    func readSearchedKeywords() -> Single<[String]>
    func saveSearchedKeyword(keyword: String)
}
