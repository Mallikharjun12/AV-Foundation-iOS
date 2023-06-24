//
//  UIView+Animation.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import UIKit

extension UIView {
    
    func animateInView( delay:TimeInterval) {
        alpha = 0
        transform = CGAffineTransform(translationX: 0, y: -20)
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.alpha = 1
            self.transform = .identity
        }
        animation.startAnimation(afterDelay: delay)
    }
    
    func animateOutView( delay:TimeInterval,completion: (()->Void)?) {
        let animation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: -20)
        }
        animation.addCompletion { _ in
            completion?()
        }
        animation.startAnimation(afterDelay: delay)
    }
}
