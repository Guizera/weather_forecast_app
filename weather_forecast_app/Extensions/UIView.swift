//
//  UIView.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 26/11/21.
//

import UIKit

extension UIView {
    
    func size(size: CGSize = .zero) {
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
