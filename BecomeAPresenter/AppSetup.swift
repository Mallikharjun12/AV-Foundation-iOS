//
//  AppSetup.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import UIKit

class AppSetup {
    
    static var keyWindow:UIWindow? {
        return UIApplication.shared.windows.first(where: {$0.isKeyWindow})
    }
    
    static func loadCaptureViewController() {
        let nibName = String(describing: CaptureViewController.self)
        let bundle = Bundle.main
        let captureVC = CaptureViewController(nibName: nibName, bundle: bundle)
        let window = Self.keyWindow
        window?.rootViewController = captureVC
        window?.makeKeyAndVisible()
    }
}
