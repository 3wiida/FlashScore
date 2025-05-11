//
//  OnboardingViewController.swift
//  FlashScore
//
//  Created by 3wiida on 11/05/2025.
//

import UIKit

class OnboardingViewController: UIViewController {

    let slides: [OnboardingSlide] = [
        OnboardingSlide(imageName: "onboarding_slide_1_image", title: "Discover Your Favorite Sports", description: "Explore a wide range of sports from around the world, all displayed beautifully in one place. Tap on any sport to dive into leagues, matches, and more!"),
        OnboardingSlide(imageName: "onboarding_slide_1_image", title: "Stay Updated with Live Events", description: "From upcoming matches to the latest scores, get all the event details at your fingertips. Never miss a moment of the action."),
        OnboardingSlide(imageName: "onboarding_slide_1_image", title: "Build Your Dream Favorites List", description: "Save leagues you love and access them anytime—even offline! Your personalized sports hub is just a tap away.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.identifier, for: indexPath) as! SlideCollectionViewCell
        cell.setupCell(slide: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
