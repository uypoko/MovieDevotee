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
    private let realmProvider: RealmProvider
    
    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
    }
    
    func fetchRecentlyViewedMovies() -> Results<GeneralMovie> {
        guard let realm = self.realmProvider.realm else {
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
            
            guard let realm = self.realmProvider.realm else {
                completable(.error(RealmProvider.RealmError.realmNotFound))
                return disposables
            }
            
            do {
                try realm.write {
                    movie.viewedDate = Date()
                    
                    if realm.object(ofType: GeneralMovie.self, forPrimaryKey: movie.id) == nil {
                        realm.add(movie)
                    }
                }
                
                completable(.completed)
            } catch {
                print("Error: \(error.localizedDescription)")
                completable(.error(error))
            }
            
            return disposables
        })
    }
    
}
