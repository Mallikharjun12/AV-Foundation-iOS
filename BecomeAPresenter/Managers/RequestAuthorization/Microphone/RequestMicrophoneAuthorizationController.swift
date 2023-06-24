//
//  RequestMicrophoneAuthorizationController.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import AVFoundation

enum MicrophoneAuthorizationStatus {
    case granted
    case notRequested
    case unauthorized
}

typealias RequestMicrophoneAuthorizationCompletionHandler = (MicrophoneAuthorizationStatus)->Void

class RequestMicrophoneAuthorizationController {
    
    static func requestMicrophoneAuthorization(completion: @escaping RequestMicrophoneAuthorizationCompletionHandler) {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                guard granted else {
                    completion(.unauthorized)
                    return
                }
                completion(.granted)
            }
        }
    }
    
    static func getMicrophoneAuthorizationStatus() -> MicrophoneAuthorizationStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
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
