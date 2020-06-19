//
//  Toast.swift
//  POC
//
//  Created by Amrit Sidhu on 18/06/20.
//  Copyright © 2020 Amrit Sidhu. All rights reserved.
//

import UIKit

/// I have used a very old code of mine to show a toast on success and failures.
/// Do not judge it for code quality
extension UIView {
    func showToast(message: String) {
        
        guard let window = UIApplication.keyWindow else { return }
        
        if let view = window.viewWithTag(2005) {
            //already present
            if let label = view.viewWithTag(2002) as? UILabel{
                label.text = message
            }
        } else {
            
            let height = getHeight(text: message, toFitFixedWidth: window.frame.width-40, font: UIFont.systemFont(ofSize: 12.0))
            
            let lockView = UIView()
            lockView.frame = CGRect(x: 10, y: (window.frame.height) , width: window.frame.width-20, height: height+20)
            
            lockView.backgroundColor = UIColor.black
            lockView.layer.cornerRadius = 5
            lockView.clipsToBounds = true
            lockView.alpha = 0.0
            lockView.tag = 2005
            
            let label = UILabel()
            label.frame = CGRect(x: 10, y: 5, width: window.frame.width-40, height: height)
            label.text = message
            label.numberOfLines = 0
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12.0)
            label.tag = 2002
            
            let info = ["view" : lockView]
            _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(hideToast), userInfo: info, repeats: false)
            
            lockView.addSubview(label)
            window.addSubview(lockView)
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
                lockView.frame = CGRect(x: 10, y: (window.frame.height) - (height+60), width: window.frame.width-20, height: height+10)
                
            }
        }
        
    }
    
    @objc func hideToast(timer: Timer) {
        
        if let info = timer.userInfo as? NSDictionary {
            let view = (info).object(forKey: "view") as? UIView
            
            let window = UIApplication.keyWindow
            
            if view?.tag == 2005 {
                UIView.animate(withDuration: 0.2, animations: {
                    view?.frame = CGRect(x: 10, y: (window!.frame.height), width: window!.frame.width-20, height: 50)
                }, completion: { (success) in
                    view?.removeFromSuperview()
                })
            }
        }
        
    }
    
    func getHeight(text:String, toFitFixedWidth fixedWidth: CGFloat, font : UIFont) -> CGFloat{
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.frame = CGRect(x: 0, y: 0, width: fixedWidth, height: 0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label.frame.height
    }
}
