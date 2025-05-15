//
//  LeagueResponse.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

struct LeagueResponse: Decodable {
    let result: [League]
}

struct League: Decodable {
    let league_key: Int
    let league_name: String
    let country_name: String?
    let league_logo: String?
}
