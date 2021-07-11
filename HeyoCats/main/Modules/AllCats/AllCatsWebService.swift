//
//  AllCatsWebService.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import Foundation

protocol CatsWebService {
    func getCatBreeds(completion: @escaping (Result<[Cat], Error>) -> Void)
}

class AllCatsWebService: CatsWebService {
    func getCatBreeds(completion: @escaping (Result<[Cat], Error>) -> Void) {
        NetworkManager.shared.makeRequest(requestType: .get, url: "\(NetworkConstants.baseURL.rawValue)/breeds", params: nil, completionHandler: completion)
    }
}
