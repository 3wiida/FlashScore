//
//  LeagueTableViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 12/05/2025.
//

import UIKit

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
        leagueLogoImageView.image = UIImage(named: "app_icon") //Remember to modify this after adding king fisher
        leagueNameLabel.text = league.league_name
        leagueCountryLabel.text = league.country_name
    }
    
}
