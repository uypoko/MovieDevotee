//
//  RealmProvider.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
    
    enum ConfigType {
        case bundleNotes
        case libraryNotes
    }
    
    enum RealmError: Error {
        case realmNotFound
    }
    
    private let pathProvider: PathProvider
    private let configType: ConfigType
    
    init(pathProvider: PathProvider, configType: ConfigType) {
        self.pathProvider = pathProvider
        self.configType = configType
    }
    
    private var libraryConfig: Realm.Configuration? {
        guard let fileURL = try? pathProvider.inLibrary("generalMovies.realm") else { return nil }
        return Realm.Configuration(
            fileURL: fileURL,
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: true,
            objectTypes: [GeneralMovie.self])
    }
    
    private var bundledConfig: Realm.Configuration? {
        return Realm.Configuration(
            fileURL: try? pathProvider.inBundle("bundledGeneralMovies.realm"),
            readOnly: true,
            objectTypes: [GeneralMovie.self])
    }
    
    var realm: Realm? {
        switch configType {
        case .libraryNotes:
            guard let libraryConfig = libraryConfig else { return nil }
            return try? Realm(configuration: libraryConfig)
        case .bundleNotes:
            guard let bundledConfig = bundledConfig else { return nil }
            return try? Realm(configuration: bundledConfig)
        }
    }
}
