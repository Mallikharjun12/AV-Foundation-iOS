//
//  RequestPhotoLibraryAuthorizationController.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import Photos

enum PhotoLibraryAuthorizationStatus {
    case granted
    case notRequested
    case unauthorized
}

typealias RequestPhotoLibraryAuthorizationCompletionHandler = (PhotoLibraryAuthorizationStatus)->Void


class RequestPhotoLibraryAuthorizationController {
    static func requestPhotoLibraryAuthorization(completion: @escaping RequestPhotoLibraryAuthorizationCompletionHandler) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                guard status == .authorized else {
                    completion(.unauthorized)
                    return
                }
                completion(.granted)
            }
        }
    }
    
    static func getPhotoLibraryAuthorizationStatus() -> PhotoLibraryAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
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
