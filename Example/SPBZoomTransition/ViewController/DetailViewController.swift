//
//  PlayerViewController.swift
//  SpotPlayer
//
//  Created by Pete Smith on 01/05/2016.
//  Copyright © 2016 Pete Smith. All rights reserved.
//

import UIKit
import Kingfisher
import SPBZoomTransition

class DetailViewController: UIViewController {
    
    // Constants
    private struct InternalConstants {
        static let CellHeight: CGFloat = 60
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Properties (public)
    var image: UIImage?
    
    // MARK: - Properties (private)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Setup
    
    // MARK: - Navigation
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}

typealias TableDelegate = DetailViewController
extension TableDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return InternalConstants.CellHeight
    }
    
}

typealias TableDatasource = DetailViewController
extension TableDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.TableCell, for: indexPath)
        
        return cell
    }
}

private typealias DestinationTransitionDelegate = DetailViewController
extension DestinationTransitionDelegate: ZoomTransitionDestinationDelegate {
    
    func transitionDestinationImageViewFrame(forward: Bool) -> CGRect {
        if forward {
            let x: CGFloat = 0.0
            let y = topLayoutGuide.length
            let width = view.frame.width
            let height = width * 2.0 / 3.0
            return CGRect(x: x, y: y, width: width, height: height)
        } else {
            return imageView.convert(imageView.bounds, to: view)
        }
    }
    
    func transitionDestinationWillBegin() {
        imageView.isHidden = true
    }
    
    func transitionDestinationDidEnd(transitioningImageView imageView: UIImageView) {
        self.imageView.isHidden = false
        self.imageView.image = imageView.image
    }
    
    func transitionDestinationDidCancel() {
        imageView.isHidden = false
    }
}
