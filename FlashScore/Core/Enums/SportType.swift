//
//  SportType.swift
//  FlashScore
//
//  Created by 3wiida on 13/05/2025.
//

enum SportType {
    case FOOTBALL
    case BASKETBALL
    case TENNIS
    case CRICKET
    
    var lowercaseName: String {
        return String(describing: self).lowercased()
    }
}
