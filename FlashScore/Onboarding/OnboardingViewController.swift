//
//  OnboardingViewController.swift
//  FlashScore
//
//  Created by 3wiida on 11/05/2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static let hasCompletedOnboardingKey = "hasCompletedOnboarding"
    
    let slides: [OnboardingSlide] = [
        OnboardingSlide(imageName: "onboarding_slide_1_image", title: "Discover Your Favorite Sports", description: "Explore a wide range of sports from around the world, all displayed beautifully in one place. Tap on any sport to dive into leagues, matches, and more!"),
        OnboardingSlide(imageName: "onboarding_slide_2_image", title: "Stay Updated with Live Events", description: "From upcoming matches to the latest scores, get all the event details at your fingertips. Never miss a moment of the action."),
        OnboardingSlide(imageName: "onboarding_slide_3_image", title: "Build Your Dream Favorites List", description: "Save leagues you love and access them anytime—even offline! Your personalized sports hub is just a tap away.")
    ]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var slidesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onNextBtnClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.set(true, forKey: OnboardingViewController.hasCompletedOnboardingKey)
        } else {
            currentPage += 1
            let indexPath = IndexPath(row: currentPage, section: 0)
            slidesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            print(currentPage)
        }
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width)
        self.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
