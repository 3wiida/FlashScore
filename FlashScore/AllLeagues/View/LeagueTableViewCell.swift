//
//  LeagueTableViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

import UIKit
import Kingfisher

class LeagueTableViewCell: UITableViewCell {

    static let identifier = "LeagueTableViewCell"
    
    @IBOutlet weak private var leagueLogoImageView: UIImageView!
    @IBOutlet weak private var leagueNameLabel: UILabel!
    @IBOutlet weak private var leagueCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(league: League){
        leagueLogoImageView.kf.setImage(
            with: URL(string: league.league_logo ?? ""),
            placeholder: UIImage(named: "app_icon"),
            options: nil,
            progressBlock: {_,_ in
                
            },
            completionHandler: { _ in
                
            }
        )
        leagueNameLabel.text = league.league_name
        leagueCountryLabel.text = league.country_name
    }
    
}
