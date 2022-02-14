//
//  CharacterService.swift
//  SwiftUIRickAndMortyAPI
//
//  Created by Richard Price on 11/02/2022.
//

import Foundation

struct CharacterService {
    enum CharacterServiceError: Error {
        case failed
        case failedToDecode
        case invalidStatusCode
    }
    
    func fetchCharacters() async throws -> [Character] {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CharacterServiceError.invalidStatusCode
        }
        
        let decodeData = try JSONDecoder().decode(CharacterSericeResult.self, from: data)
        return decodeData.results
        
    }
}
