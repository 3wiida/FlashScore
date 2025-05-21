//
//  LoadingStateCollectionViewCell.swift
//  FlashScore
//
//  Created by 3wiida on 21/05/2025.
//

import UIKit

class LoadingStateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingIndicator.startAnimating()
    }

}
