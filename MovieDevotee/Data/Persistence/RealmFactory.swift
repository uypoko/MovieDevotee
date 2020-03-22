//
//  RealmProvider.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmFactory {
    
    enum DirectoryType {
        case documents
        case library
    }
    
    private let pathFactory: PathFactory
    
    init(pathFactory: PathFactory) {
        self.pathFactory = pathFactory
    }
    
    func makeRealm<T: Object>(fileName: String, directoryType: DirectoryType, objectTypes: [T.Type]) throws -> Realm {
        var fileURL: URL
        
        switch directoryType {
        case .documents:
            fileURL = try pathFactory.inDocuments(fileName)
        case .library:
            fileURL = try pathFactory.inLibrary(fileName)
        }
        
        let config = Realm.Configuration(
            fileURL: fileURL,
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: true,
            objectTypes: objectTypes)
        
        return try Realm(configuration: config)
    }
    
}
