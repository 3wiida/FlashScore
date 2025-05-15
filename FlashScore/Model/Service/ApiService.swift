//
//  ApiService.swift
//  FlashScore
//
//  Created by 3wiida on 13/05/2025.
//

import Alamofire

protocol ApiService {
    static func fetchAllLeagues(sportType: SportType, completion: @escaping (LeagueResponse?, Error?) -> Void)
}

class ApiServiceImpl : ApiService {
    private static let API_KEY = "4c5887978a5907a2f6dee9701262149f37e70b0b9fd4c04132490c7a86cfdc65"
    
    static func fetchAllLeagues(sportType: SportType,completion: @escaping (LeagueResponse?, Error?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sportType.lowercaseName)/?met=Leagues&APIkey=\(API_KEY)"
        AF.request(url).responseDecodable(of: LeagueResponse.self) { response in
            switch response.result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
}
