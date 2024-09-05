//
//  UIAlertView.swift
//  Demo_Task
//
//  Created by ToqSoft on 06/09/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showNoInternetAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 4
        layer.cornerRadius = 5
        layer.masksToBounds = false
    }
}
