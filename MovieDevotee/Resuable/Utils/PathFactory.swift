//
//  PathProvider.swift
//  MovieDevotee
//
//  Created by Ryan on 3/4/20.
//  Copyright © 2020 Daylighter. All rights reserved.
//

import Foundation

struct PathFactory {
    
    enum PathError: Error {
        case notFound
    }
    
    func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }

    func inDocuments(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }
    
    func inBundle(_ name: String) throws -> URL {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            throw PathError.notFound
        }
        return url
    }
}
