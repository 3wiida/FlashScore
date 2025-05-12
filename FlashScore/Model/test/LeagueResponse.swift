//
//  LeagueResponse.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

struct LeagueResponse {
    let result: [League]
}

struct League {
    let league_key: String
    let league_name: String
    let country_name: String
    let league_logo: String?
}
