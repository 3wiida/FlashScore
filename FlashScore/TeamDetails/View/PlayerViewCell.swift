//
//  PlayerViewCell.swift
//  FlashScore
//
//  Created by ziad helaly on 19/05/2025.
//

import UIKit
import Kingfisher
class PlayerViewCell: UITableViewCell {

    @IBOutlet weak var playerImg: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    static var identifier="playerCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(player:Player){
        playerImg.layer.cornerRadius=playerImg.frame.width/2
        playerImg.clipsToBounds=true
        playerImg.kf.setImage(with: URL(string: player.player_image),placeholder: UIImage(named: "player"))
        playerName.text=player.player_name
        playerType.text=player.player_type
        playerNumber.text=player.player_number
    }

}
