//
//  TennisPlayer.swift
//  FlashScore
//
//  Created by ziad helaly on 20/05/2025.
//

import Foundation

struct TennisPlayerResponse:Codable {
    let result:[TennisPlayerDetails]
}
struct TennisPlayerDetails:Codable {
    let player_key: Int?
    let player_name: String?
    let player_logo: String?
    let player_country: String?
    let stats:[Season]?
    let tournaments:[Tournament]?
}
struct Season:Codable {
    let season:String?
    let type:String?
    let rank:String?
    let matches_won:String?
}
struct Tournament:Codable {
    let name:String?
}
