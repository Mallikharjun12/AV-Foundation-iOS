//
//  RequestCameraAuthorizationView.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import UIKit

protocol RequestCameraAuthorizationViewDelegate:AnyObject {
    func requestCameraAuthorizationTapped()
}

class RequestCameraAuthorizationView: UIView {

    @IBOutlet private weak var contentView:UIView!
    @IBOutlet private weak var cameraImageViw:UIImageView!
    @IBOutlet private weak var titleLabel:UILabel!
    @IBOutlet private weak var messageLabel:UILabel!
    @IBOutlet private weak var actionButton:UIButton!
    
    @IBOutlet private weak var actionBtnWidthConstraint:NSLayoutConstraint!
    
    weak var delegate:RequestCameraAuthorizationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder:NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        let bundle = Bundle.main
        let nibName = String(describing: Self.self)
        bundle.loadNibNamed(nibName, owner: self)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        addActionButtonShadow()
    }
    
    @IBAction func actionButtonHandler(sender:UIButton) {
        delegate?.requestCameraAuthorizationTapped()
    }
    
    public func animateInViews() {
        
        let viewsToAnimate = [cameraImageViw,titleLabel,messageLabel,actionButton]
        
        for (i,viewToAnimate) in viewsToAnimate.enumerated() {
            guard let view = viewToAnimate else {
                continue
            }
            view.animateInView(delay: Double(i) * 0.3)
        }
    }
    
    public func animateOutViews(completion: @escaping ()->Void) {
        let viewsToAnimate = [cameraImageViw,titleLabel,messageLabel,actionButton]
        
        for (i,viewToAnimate) in viewsToAnimate.enumerated() {
            guard let view = viewToAnimate else {
                continue
            }
            var completionToCall:(()->Void)? = nil
            if viewToAnimate == viewsToAnimate.last {
                completionToCall = completion
            }
            view.animateOutView(delay: Double(i) * 0.2, completion: completionToCall)
        }
    }
    
    public func configureForErrorState() {
        titleLabel.text = "Camera Authorization Denied"
        actionButton.setTitle("Open Settings", for: .normal)
    }
}


//MARK: Layer
 extension RequestCameraAuthorizationView {
     
     private func addActionButtonShadow() {
         actionButton.addShadow()
    }
}
