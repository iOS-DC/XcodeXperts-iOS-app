//
//  TrackerViewController.swift
//  HerHub
//
//  Created by Assistant on 11/10/25.
//

import UIKit

final class TrackerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Body Climate"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor.systemBackground
    }
}


