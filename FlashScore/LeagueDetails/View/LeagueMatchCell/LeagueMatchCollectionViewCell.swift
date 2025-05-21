//
//  LeagueMatchCollectionViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 16/05/2025.
//

import UIKit
import Kingfisher

class LeagueMatchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var firstTeamLogo: UIImageView!
    @IBOutlet weak private var secondTeamLogo: UIImageView!
    @IBOutlet weak private var firstTeamNameLabel: UILabel!
    @IBOutlet weak private var secondTeamNameLabel: UILabel!
    @IBOutlet weak private var matchScoreLabel: UILabel!
    @IBOutlet weak private var matchTimeLabel: UILabel!
    @IBOutlet weak private var matchDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(match:CommonMatch, isUpcoming:Bool) {
        statusLabel.text = isUpcoming ? "Upcoming" : "Finished"
        
        firstTeamLogo.kf.setImage(
            with: URL(string: match.home_team_logo),
            placeholder: UIImage(named: "app_icon"),
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
        
        secondTeamLogo.kf.setImage(
            with: URL(string: match.away_team_logo),
            placeholder: UIImage(named: "app_icon"),
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ]
        )
        
        firstTeamNameLabel.text = match.event_home_team
        secondTeamNameLabel.text = match.event_away_team
        
        matchScoreLabel.text = isUpcoming ? "- / -" : match.event_final_result
        
        matchTimeLabel.text = match.event_time
        matchDateLabel.text = match.event_date
    }

}
