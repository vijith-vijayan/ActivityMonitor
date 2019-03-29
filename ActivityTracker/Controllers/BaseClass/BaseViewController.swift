//
//  BaseViewController.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

enum Direction {
    case right
    case left
}

class BaseViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 15.0, height: 25.0)
        button.tintColor = .black
        button.setImage(UIImage(named: "back.png"), for: .normal)
        button.addTarget(self, action: #selector(self.goBack), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func navigationBar(imageName: String, direction: Direction) {
        
        var image = UIImage(named: imageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        switch direction {
        case .left:
            let barItem = UIBarButtonItem(customView: backButton)
            barItem.customView?.translatesAutoresizingMaskIntoConstraints = false
            barItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
            barItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
            self.navigationItem.leftBarButtonItem = barItem
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: #selector(goBack))
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func goBack() {
        self.performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
}
