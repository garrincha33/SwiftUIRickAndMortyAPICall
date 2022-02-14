//
//  Service.swift
//  SwiftUIRickAndMortyAPI
//
//  Created by Richard Price on 11/02/2022.
//

import Foundation

struct CharacterSericeResult: Codable {
    let results: [Character]
}
struct Character: Codable {
    let id: Int
    let name: String
}

