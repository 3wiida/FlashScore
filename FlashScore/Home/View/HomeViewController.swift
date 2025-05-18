//
//  HomeViewController.swift
//  FlashScore
//
//  Created by ziad helaly on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let sports = [
        Sport(name: "Football", img: "football"),
        Sport(name: "BasketBall", img: "basketball"),
        Sport(name: "Tennis", img: "tennis"),
        Sport(name: "Cricket", img: "cricket")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell (if using .xib or code-based cell)
        // Comment this if you're using storyboard prototype cell
        // collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Configure layout spacing
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 16
        }
        
        self.navigationItem.title = "Home"
    }
    
    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        // Configure the cell
        cell.sportImg.image = UIImage(named: sports[indexPath.row].img)
    
        cell.sportLabel.text = sports[indexPath.row].name
        
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 16
        let spacing: CGFloat = 10
        let columns: CGFloat = 2

        let totalSpacing = (2 * padding) + ((columns - 1) * spacing)
        let width = (collectionView.bounds.width - totalSpacing) / columns
        let height = (collectionView.bounds.height - totalSpacing) / columns - 60

        return CGSize(width: width, height: height)
        //return CGSize(width: 80, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        let allLeaguesVC = storyboard?.instantiateViewController(withIdentifier: "AllLeaguesVC") as! AllLeaguesViewController
        switch indexPath.row{
        case 0:
            allLeaguesVC.sportType = .FOOTBALL
            break
        case 1:
            allLeaguesVC.sportType = .BASKETBALL
            break
        case 2:
            allLeaguesVC.sportType = .TENNIS
            break
        default:
            allLeaguesVC.sportType = .CRICKET
        }
        allLeaguesVC.sportType = .FOOTBALL
        self.navigationController?.pushViewController(allLeaguesVC, animated: true)
    }
}
