//
//  Extensions.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 14/02/2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

extension UICollectionView {
    func setEmptyMessage(_ message: ResultMessage) {
        let messageLabel = UILabel()
        messageLabel.text = message.text
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        messageLabel.sizeToFit()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = messageLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }

    func restore() {
        self.backgroundView = nil
    }
}
