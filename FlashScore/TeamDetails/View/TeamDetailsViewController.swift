//
//  TeamDetailsViewController.swift
//  FlashScore
//
//  Created by ziad helaly on 19/05/2025.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var coachSection: UIView!
    @IBOutlet weak var sportLabel: UILabel!
    private var team:Team!
    var teamId:String! = "96"
    var sportType:SportType! = .FOOTBALL
    
    var players:[Player]?=nil
    let presenter:TeamDetailsPresenterContract=TeamDetailsPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachViewController(view: self)
        presenter.getTeamDetails(teamId: teamId, sportType: sportType)
    }
    
}

extension TeamDetailsViewController:TeamDetailsViewContract{
    func renderData(teamDetails: Team?) {
        sportLabel.text="\(sportType.lowercaseName.capitalized) team"
        logo.kf.setImage(with: URL(string: teamDetails?.team_logo ?? ""))
        teamName.text=teamDetails?.team_name
        if let coachs=teamDetails?.coaches{
            let coach=coachs[0]
            coachName.text=coach.coach_name
        }else{
            coachSection.isHidden=true
        }
        if let players=teamDetails?.players {
            self.players=players
            playersTable.reloadData()
        }else{
            playersTable.isHidden=true
        }
    }
    
    func showErrorMsg(msg: String) {
        print(msg)
    }
}
extension TeamDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Players"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            header.contentView.backgroundColor = UIColor.black
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerViewCell.identifier, for: indexPath) as! PlayerViewCell
        if let players=players{
            let player = players[indexPath.row]
            cell.setup(player: player)
        }
        return cell
    }
}
