//
//  SlideCollectionViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 11/05/2025.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SlideCollectionViewCell"
    
    @IBOutlet weak private var slideDescriptionLabel: UILabel!
    @IBOutlet weak private var slideTitleLabel: UILabel!
    @IBOutlet weak private var slideImageView: UIImageView!
    
    func setupCell(slide: OnboardingSlide){
        slideImageView.image = UIImage(named: slide.imageName)
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
