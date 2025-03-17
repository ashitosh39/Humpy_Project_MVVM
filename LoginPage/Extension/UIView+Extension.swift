//
//  UIView+Extension.swift
//  LoginPage
//
//  Created by Digitalflake on 05/02/25.
//


import UIKit

extension UIView {
    @IBInspectable var cornerRedius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
