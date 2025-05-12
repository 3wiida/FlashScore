//
//  SlideCollectionViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 11/05/2025.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SlideCollectionViewCell"
    
    @IBOutlet weak private var slideImageView: UIImageView!
    
    @IBOutlet weak var slideTitleLabel: UILabel!
    
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func setupCell(slide: OnboardingSlide){
        slideImageView.image = UIImage(named: slide.imageName)
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
