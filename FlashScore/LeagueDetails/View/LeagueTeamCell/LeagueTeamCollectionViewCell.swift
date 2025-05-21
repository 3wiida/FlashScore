//
//  LeagueTeamCollectionViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

import UIKit

class LeagueTeamCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak private var teamLogo: UIImageView!
    @IBOutlet weak private var teamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(team: CommonTeam){
        teamLogo.kf.setImage(
            with: URL(string: team.team_logo),
            placeholder: UIImage(named: "app_icon"),
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
        
        teamNameLabel.text = team.team_name
    }

}
