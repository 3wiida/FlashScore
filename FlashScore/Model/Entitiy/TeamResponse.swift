//
//  TeamResponse.swift
//  FlashScore
//
//  Created by ziad helaly on 19/05/2025.
//

import Foundation

struct TeamResponse: Codable{
    let result:[Team]
}

struct Team: Codable {
    let team_key:Int
    let team_name:String
    let team_logo:String
    let players:[Player]?
    let coaches:[Coach]?
    
}
struct Player: Codable {
    let player_name:String
    let player_image:String
    let player_number:String
    let player_type:String
}
struct Coach:Codable {
    let coach_name:String
    let coach_country:String?
    let coach_age:String?
}
