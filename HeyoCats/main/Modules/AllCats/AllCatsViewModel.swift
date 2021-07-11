//
//  AllCatsViewModel.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import Foundation
import Combine

protocol AllCatsViewModelActions {
    func getCats()
    func isFavotite(row: Int) -> Bool
    func saveCat(row: Int) -> Bool
}

class AllCatsViewModel: ObservableObject, AllCatsViewModelActions {
    let webService: CatsWebService
    
    @Published var cats = [Cat]()
    
    init(webService: CatsWebService) {
        self.webService = webService
        getCats()
    }
    
    func getCats() {
        webService.getCatBreeds { response in
            switch response {
            case .success(let cats):
                self.cats = cats
            case .failure:
                break
            }
        }
    }
    
    func isFavotite(row: Int) -> Bool {
        CatsPersistenceManager.shared.load().first(where: {$0.id == self.cats[row].id}) == nil ? false : true
    }
    
    func saveCat(row: Int) -> Bool {
        if isFavotite(row: row) {
            CatsPersistenceManager.shared.remove(cat: cats[row])
            return false
        }else {
            CatsPersistenceManager.shared.save(cat: cats[row])
            return true
        }
    }
}
