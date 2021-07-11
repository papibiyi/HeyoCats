//
//  CatModel.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 08/07/2021.
//

import Foundation

struct Cat: Codable, Equatable {
    let id: String?
    let image: Image?
    let name: String?
}

// MARK: - Image
struct Image: Codable, Equatable {
    let id: String?
    let url: String?
}

struct Favourites: Codable {
    let cats: [Cat]
}
