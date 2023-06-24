//
//  RequestAuthorizationController.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import Foundation
import AVFoundation

enum CameraAuthorizationStatus {
    case granted
    case notRequested
    case unauthorized
}

typealias RequestCameraAuthorizationCompletionHandler = (CameraAuthorizationStatus)->Void

class RequestCameraAuthorizationController {
    
    static func requestCameraAuthorization(completion: @escaping RequestCameraAuthorizationCompletionHandler) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                guard granted else {
                    completion(.unauthorized)
                    return
                }
                completion(.granted)
            }
        }
    }
    
    static func getCameraAuthorizationStatus() -> CameraAuthorizationStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            return .notRequested
        case .authorized:
            return .granted
        default:
            return .unauthorized
        }
    }
}
