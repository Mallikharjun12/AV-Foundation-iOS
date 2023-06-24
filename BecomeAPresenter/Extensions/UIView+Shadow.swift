//
//  UIView+Shadow.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 5, height: 10)
    }
}
