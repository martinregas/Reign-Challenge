//
//  UIViewController+Extension.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import Foundation
import UIKit

extension UIViewController {
    func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func showAlertWith(title:String? = nil, message: String, dismissCurrentViewController: Bool = false) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            
            alert.dismiss(animated: true, completion: nil)
            if dismissCurrentViewController {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        
        return alert
    }
}
