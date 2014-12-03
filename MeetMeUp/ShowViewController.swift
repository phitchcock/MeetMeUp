//
//  ShowViewController.swift
//  MeetMeUp
//
//  Created by Peter Hitchcock on 12/3/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    var event: Event!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = event.name
        addressLabel.text = event.address
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
