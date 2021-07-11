//
//  CatsPersistenseManager.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 11/07/2021.
//

import Foundation

class CatsPersistenceManager {
    
   static let shared = CatsPersistenceManager()
    
    private init () {}
    
    private static var documentsFolder: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private static var fileURL: URL? {
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            //Append path during app usage
            return documentsFolder?.appendingPathComponent("favouriteCats.data")
        }else {
            //Append path during when running Testcases
            return documentsFolder?.appendingPathComponent("test.data")
        }
    }
    
    func load() -> [Cat] {
        guard let url = CatsPersistenceManager.fileURL else { return [] }
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let favourite = try? JSONDecoder().decode(Favourites.self, from: data) else { return [] }
        return favourite.cats
    }
    
    func save(cat: Cat) {
            var cats = self.load()
            guard !cats.contains(where: { (data) -> Bool in
                data.id == cat.id
            }) else {return}
            cats.append(cat)
            guard let data = try? JSONEncoder().encode(Favourites(cats: cats)) else { fatalError("Error encoding data") }
            guard let url = CatsPersistenceManager.fileURL else { return }
            try? data.write(to: url)
    }
    
    @discardableResult
    func remove(cat: Cat) -> Int? {
        var cats = self.load()
        guard let index = cats.firstIndex(where: { $0.id == cat.id}) else {return nil}
        cats.remove(at: index)
        guard let data = try? JSONEncoder().encode(Favourites(cats: cats)) else { fatalError("Error encoding data") }
        guard let url = CatsPersistenceManager.fileURL else { return nil}
        try? data.write(to: url)
        return index
    }
    
    func clear() {
        guard let data = try? JSONEncoder().encode(Favourites(cats: [])) else { fatalError("Error encoding data") }
        guard let url = CatsPersistenceManager.fileURL else { return }
        try? data.write(to: url)
    }
}
