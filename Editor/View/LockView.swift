//
//  UIView.swift
//  POC
//
//  Created by Amrit Sidhu on 18/06/20.
//  Copyright © 2020 Amrit Sidhu. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationView: UIView {
    
    func removeView() {
        self.removeFromSuperview()
    }
    
    func authenticate() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthentication,
            error: &error) {
            
            // Device can use  authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthentication,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {
                        
                        if let err = error {
                            
                            switch err._code {
                                
                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                                err: err.localizedDescription)
                                
                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: err.localizedDescription)
                                
                            default:
                                self.notifyUser("Authentication failed",
                                                err: err.localizedDescription)
                            }
                            
                        } else {
                            self.removeView()
                            self.notifyUser("Authentication Successful",
                                            err: "You now have full access")
                        }
                    }
            })
            
        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code {
                    
                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)
                    
                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)
                    
                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }
    }
    
    
    func notifyUser(_ msg: String, err: String?) {
        let alert = UIAlertController(title: msg,
                                      message: err,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.showToast(message: err ?? "")
    }
}


