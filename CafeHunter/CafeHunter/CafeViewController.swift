//
//  CafeViewController.swift
//  CafeHunter
//
//  Created by Long Vinh Nguyen on 10/12/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

@objc protocol CafeViewControllerDelegate {
    optional func cafeViewControllerDidFinish(viewController:CafeViewController)
}

class CafeViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    weak var delegate:CafeViewControllerDelegate?
    
    var cafe:Cafe? {
        didSet {
            self.setupWithCafe()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWithCafe()
    }
    
    func setupWithCafe() {
        if !self.isViewLoaded() {
            return
        }
        
        if let cafe = self.cafe {
            self.title = cafe.name
            self.nameLabel.text = cafe.name
            self.streetLabel.text = cafe.street
            self.cityLabel.text = cafe.city
            self.zipLabel.text = cafe.zip
            
            let request = NSURLRequest(URL: cafe.pictureURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
                let image = UIImage(data: data)
                self.imageView.image = image
            })
            
        }
    }
    
    @IBAction private func back(sender:AnyObject) {
        self.delegate?.cafeViewControllerDidFinish?(self)
    }
}
