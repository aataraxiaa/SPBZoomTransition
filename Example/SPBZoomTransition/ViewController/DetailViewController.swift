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
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
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


typealias ZoomDestinationDelegate = DetailViewController
extension ZoomDestinationDelegate: ZoomAnimatorDestinationDelegate {
    
    func destinationFrame() -> CGRect {
        return CGRect(x: 0, y: 30.0, width: view.bounds.width, height: view.bounds.width)
    }
}
