//
//  TennisPlayerViewController.swift
//  FlashScore
//
//  Created by ziad helaly on 20/05/2025.
//

import UIKit
import Kingfisher
protocol TennisPlayerViewContract {
    func renderData(player:TennisPlayerDetails?)
}
class TennisPlayerViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var tourmentsCount: UILabel!
    @IBOutlet weak var playerCountry: UILabel!
    @IBOutlet weak var seasonType: UILabel!
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var playerRank: UILabel!
    @IBOutlet weak var matchesWon: UILabel!
    @IBOutlet weak var playerName: UILabel!
    var playerId:String!="1905"
    var presenter:TennisPlayerPresenterContract!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=TennisPlayerPresenter()
        presenter.attachViewController(view: self)
        presenter.getData(playerId: playerId)
    }

}
extension TennisPlayerViewController: TennisPlayerViewContract{
    func renderData(player:TennisPlayerDetails?) {
        logo.kf.setImage(with: URL(string: player?.player_logo ?? ""), placeholder: UIImage(named: "player"))
        tourmentsCount.text="\(player?.tournaments?.count ?? 0)"
        playerCountry.text=player?.player_country ?? "USA"
        let stat:Season?=player?.stats?[0]
        playerRank.text=stat?.rank ?? "7"
        playerName.text=player?.player_name ?? "Tomus Muller"
        seasonType.text=stat?.type ?? "indevidual"
        season.text=stat?.season ?? "2024"
        matchesWon.text=stat?.matches_won ?? "11"
    }
}
