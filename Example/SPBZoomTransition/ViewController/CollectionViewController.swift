//
//  MusicViewController.swift
//  SpotPlayer
//
//  Created by Pete Smith on 30/04/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit
import SPBZoomTransition

class CollectionViewController: UIViewController {
    
    // Constants
    private struct InternalConstants {

    }
    
    // MARK: - Properties (Public)
    
    // MARK: - Properties (Private)
    private var selectedImageView: UIImageView!
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Get stuff
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) { // let navViewController = segue.destinationViewController as? UINavigationController,
        if let detailViewController = segue.destinationViewController as? DetailViewController, let collectionCell = sender as? CollectionCell, let image = collectionCell.imageView.image {
            detailViewController.image = image
        }
    }
}

typealias CollectionViewDelegate = CollectionViewController
extension CollectionViewDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collectionCell = collectionView.cellForItem(at: indexPath) as? CollectionCell {
            selectedImageView = collectionCell.imageView
        }
    }
}

private typealias CollectionViewDatasource = CollectionViewController
extension CollectionViewDatasource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.CollectionCell, for: indexPath) as? CollectionCell {
            
            cell.index = indexPath.row
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

private typealias FlowLayoutDelegate = CollectionViewController
extension FlowLayoutDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set up cell dimensions
        let width = (collectionView.bounds.width/2) - 2
        return CGSize(width: width, height: width)
        
    }
}

private typealias TransitionSourceDelegate = CollectionViewController
extension TransitionSourceDelegate: ZoomTransitionSourceDelegate {
    
    func transitionSourceImageView() -> UIImageView {
        return selectedImageView
    }
    
    func transitionSourceImageViewFrame(forward: Bool) -> CGRect {
        return selectedImageView.convert(selectedImageView.bounds, to: view)
    }
    
    func transitionSourceWillBegin() {
        selectedImageView.isHidden = true
    }
    
    func transitionSourceDidEnd() {
        selectedImageView.isHidden = false
    }
    
    func transitionSourceDidCancel() {
        selectedImageView.isHidden = false
    }
}
