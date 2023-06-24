//
//  LaunchViewController.swift
//  BecomeAPresenter
//
//  Created by Mallikharjun kakarla on 04/06/23.
//

import UIKit

class LaunchViewController: UIViewController {

    private var requestCameraAuthorizationView:RequestCameraAuthorizationView?
    private var requestMicrophoneAuthorizationView:RequestMicrophoneAuthorizationView?
    private var requestPhotoLibraryAuthorizationView:RequestPhotoLibraryAuthorizationView?
    
    private var cameraAuthorizationStatus = RequestCameraAuthorizationController.getCameraAuthorizationStatus() {
        didSet {
            self.setUpViewForNextAuthorizationRequest()
        }
    }
    
    private var microphoneAuthorizationStatus = RequestMicrophoneAuthorizationController.getMicrophoneAuthorizationStatus() {
        didSet {
            self.setUpViewForNextAuthorizationRequest()
        }
    }
    
    private var photoLibraryAuthorizationStatus = RequestPhotoLibraryAuthorizationController.getPhotoLibraryAuthorizationStatus() {
        didSet {
            self.setUpViewForNextAuthorizationRequest()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewForNextAuthorizationRequest()
    }
}


extension LaunchViewController {

    private func setUpViewForNextAuthorizationRequest() {
        guard cameraAuthorizationStatus == .granted else {
            setUpRequestCameraAuthorizationView()
            return
        }
        
        if let _ = requestCameraAuthorizationView {
            removeRequestCameraAuthorizationView()
            return
        }
        
        guard microphoneAuthorizationStatus == .granted else {
            setUpRequestMicrophoneAuthorizationView()
            return
        }
        
        if let _ = requestMicrophoneAuthorizationView {
            removeRequestMicrophoneAuthorizationView()
            return
        }
        
        guard photoLibraryAuthorizationStatus == .granted else {
            setUpRequestPhotoLibraryAuthorizationView()
            return
        }
        
        if let _ = requestPhotoLibraryAuthorizationView {
            removeRequestPhotoLibraryAuthorizationView()
            return
        }
        
        print("Going to capture View Controller")
        DispatchQueue.main.async {
            AppSetup.loadCaptureViewController()
        }
    }
    
  //MARK: Requesting permission for camera
  private func setUpRequestCameraAuthorizationView() {
          guard requestCameraAuthorizationView == nil else {
              if cameraAuthorizationStatus == .unauthorized {
                  requestCameraAuthorizationView?.configureForErrorState()
              }
              return
          }
      
        let requestView = RequestCameraAuthorizationView()
        requestView.delegate = self
        requestView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(requestView)
        NSLayoutConstraint.activate([
            requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            requestView.topAnchor.constraint(equalTo: view.topAnchor),
            requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
      if cameraAuthorizationStatus == .unauthorized {
          requestView.configureForErrorState()
      }
        requestView.animateInViews()
       self.requestCameraAuthorizationView = requestView
    }
    
    private func removeRequestCameraAuthorizationView() {
        guard let requestCameraAuthorizationView = requestCameraAuthorizationView else {
            return
        }
        requestCameraAuthorizationView.animateOutViews { [weak self] in
                requestCameraAuthorizationView.removeFromSuperview()
                self?.requestCameraAuthorizationView = nil
                self?.setUpViewForNextAuthorizationRequest()
        }
    }
    
    //MARK: requesting permission for microphone
    private func setUpRequestMicrophoneAuthorizationView() {
            guard requestMicrophoneAuthorizationView == nil else {
                if microphoneAuthorizationStatus == .unauthorized {
                    requestMicrophoneAuthorizationView?.configureForErrorState()
                }
                return
            }
        
          let requestView = RequestMicrophoneAuthorizationView()
          requestView.delegate = self
          requestView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(requestView)
          NSLayoutConstraint.activate([
              requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              requestView.topAnchor.constraint(equalTo: view.topAnchor),
              requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
          ])
        if microphoneAuthorizationStatus == .unauthorized {
            requestView.configureForErrorState()
        }
          requestView.animateInViews()
         self.requestMicrophoneAuthorizationView = requestView
      }
      
      private func removeRequestMicrophoneAuthorizationView() {
          guard let requestMicrophoneAuthorizationView = requestMicrophoneAuthorizationView else {
              return
          }
          requestMicrophoneAuthorizationView.animateOutViews { [weak self] in
              requestMicrophoneAuthorizationView.removeFromSuperview()
                  self?.requestMicrophoneAuthorizationView = nil
                  self?.setUpViewForNextAuthorizationRequest()
          }
      }
    
    //MARK: Requesting permission for photo Library
    private func setUpRequestPhotoLibraryAuthorizationView() {
            guard requestPhotoLibraryAuthorizationView == nil else {
                if photoLibraryAuthorizationStatus == .unauthorized {
                    requestPhotoLibraryAuthorizationView?.configureForErrorState()
                }
                return
            }
        
          let requestView = RequestPhotoLibraryAuthorizationView()
          requestView.delegate = self
          requestView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(requestView)
          NSLayoutConstraint.activate([
              requestView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              requestView.topAnchor.constraint(equalTo: view.topAnchor),
              requestView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              requestView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
          ])
        if photoLibraryAuthorizationStatus == .unauthorized {
            requestView.configureForErrorState()
        }
          requestView.animateInViews()
         self.requestPhotoLibraryAuthorizationView = requestView
      }
      
      private func removeRequestPhotoLibraryAuthorizationView() {
          guard let requestPhotoLibraryAuthorizationView = requestPhotoLibraryAuthorizationView else {
              return
          }
          requestPhotoLibraryAuthorizationView.animateOutViews { [weak self] in
              requestPhotoLibraryAuthorizationView.removeFromSuperview()
                  self?.requestPhotoLibraryAuthorizationView = nil
                  self?.setUpViewForNextAuthorizationRequest()
          }
      }
    
    private func openSettings() {
        let settingsUrlString = UIApplication.openSettingsURLString
        print(settingsUrlString)
        if let url = URL(string: settingsUrlString) {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: RequestCameraAuthorizationViewDelegate
extension LaunchViewController:RequestCameraAuthorizationViewDelegate {
    
    func requestCameraAuthorizationTapped() {
        if cameraAuthorizationStatus == .notRequested {
            RequestCameraAuthorizationController.requestCameraAuthorization {[weak self] status in
                guard let self = self else {
                    return
                }
                self.cameraAuthorizationStatus = status
            }
            return
        }
        
        if cameraAuthorizationStatus == .unauthorized {
            self.openSettings()
            return
        }
    }
}

//MARK: RequestMicrophoneAuthorizationViewDelegate
extension LaunchViewController:RequestMicrophoneAuthorizationViewDelegate {
    
    func requestMicrophoneAuthorizationTapped() {
        if microphoneAuthorizationStatus == .notRequested {
            RequestMicrophoneAuthorizationController.requestMicrophoneAuthorization {[weak self] status in
                guard let self = self else {
                    return
                }
                self.microphoneAuthorizationStatus = status
            }
            return
        }
        
        if microphoneAuthorizationStatus == .unauthorized {
            self.openSettings()
            return
        }
    }
}

//MARK: RequestPhotoLibraryAuthorizationViewDelegate
extension LaunchViewController:RequestPhotoLibraryAuthorizationViewDelegate {
    
    func requestPhotoLibraryAuthorizationTapped() {
        if photoLibraryAuthorizationStatus == .notRequested {
            RequestPhotoLibraryAuthorizationController.requestPhotoLibraryAuthorization {[weak self] status in
                guard let self = self else {
                    return
                }
                self.photoLibraryAuthorizationStatus = status
            }
            return
        }
        
        if photoLibraryAuthorizationStatus == .unauthorized {
            self.openSettings()
            return
        }
    }
}

