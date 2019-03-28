//
//  TabelView+Extension.swift
//  ActivityTracker
//
//  Created by Vijith TV on 28/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Set Empty View
    ///
    /// - Parameters:
    ///   - title: Title shown in empty view
    ///   - message: Message shown in empty view
    ///   - emptyImage: Image shown in empty view
    public func emptyMessage(title: String, message: String, emptyImage: UIImage) {
        
        let frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        let emptyView = UIView(frame: frame)
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17.0)
        
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20.0).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = emptyImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1.0, animations: {
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }) { (finish) in
            UIView.animate(withDuration: 1.0, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finish) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
        }
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restoreTableView() {
        
        self.backgroundView = nil
        
    }
    
}
