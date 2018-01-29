//
//  ViewController.swift
//  DropBoxList
//
//  Created by Hanumant S on 29/01/18.
//  Copyright © 2018 Hanumant S. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        setTitle()
    }
    
    func setTitle() {
        self.title = "Feeds"
    }
}

