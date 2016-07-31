//
//  AlbumCell.swift
//  SpotPlayer
//
//  Created by Pete Smith on 01/05/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties (public)
    var index: Int? {
        didSet {
            // When the album is set, get the cover art
            if let url = URL(string: catURL) {
                imageView.kf_setImageWithURL(url, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler:{(image: Image?, error: NSError?, cacheType: CacheType, imageURL: URL?) in})
            }
        }
    }
    
    private let catURL = "https://placekitten.com/300/300"
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
