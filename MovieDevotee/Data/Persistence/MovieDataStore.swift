//
//  MovieDataStore.swift
//  MovieDevotee
//
//  Created by Ryan on 2/25/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class MovieDataStore {
    private let realmFactory: RealmFactory
    private let movieRealmFileName = "movies.realm"
    
    init(realmFactory: RealmFactory) {
        self.realmFactory = realmFactory
    }
    
    func fetchRecentlyViewedMovies() -> Results<GeneralMovie> {
        guard let realm = try? realmFactory.makeRealm(fileName: movieRealmFileName, directoryType: .documents, objectTypes: [GeneralMovie.self]) else {
            fatalError("realm nil")
        }
        
        let sortedMovies = realm.objects(GeneralMovie.self)
            .sorted(byKeyPath: GeneralMovie.Properties.viewedDate.rawValue, ascending: false)
        
        return sortedMovies
    }
    
    func saveMovieToRecetlyViewed(movie: GeneralMovie) -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            let disposables = Disposables.create()
            guard let self = self else { return disposables }
            
            do {
                let realm = try self.realmFactory
                    .makeRealm(fileName: self.movieRealmFileName, directoryType: .documents, objectTypes: [GeneralMovie.self])
                
                try realm.write {
                    movie.viewedDate = Date()
                    
                    if realm.object(ofType: GeneralMovie.self, forPrimaryKey: movie.id) == nil {
                        realm.add(movie)
                    }
                }
                
                completable(.completed)
            } catch (let error) {
                completable(.error(error))
            }
            
            return disposables
        })
    }
    
}
