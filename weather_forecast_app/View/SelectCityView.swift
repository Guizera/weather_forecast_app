//
//  SelectCityView.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import UIKit

class SelectCityView: UIView {
    
    var cityTextField: UITextField!
    var currentLocationButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cityTextField = UITextField()
        cityTextField.attributedPlaceholder = NSAttributedString(string: "search city", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Grey") ?? .white])
        cityTextField.layer.masksToBounds = false
        cityTextField.borderStyle = .none
        cityTextField.backgroundColor = UIColor(named: "ClearGrey")
        cityTextField.alpha = 0.5
        cityTextField.layer.borderColor = UIColor(named: "ClearGrey")?.cgColor
        cityTextField.textColor = UIColor(named: "DarkGrey")
        cityTextField.layer.borderWidth = 2.0
        cityTextField.layer.cornerRadius = 8
        cityTextField.returnKeyType = .go
        cityTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        cityTextField.leftView = UIView(frame: CGRect(x: 0,y: 0,width: 25,height: 0))
        cityTextField.leftViewMode = UITextField.ViewMode.always
        cityTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        cityTextField.rightViewMode = UITextField.ViewMode.always
        
        self.addSubview(cityTextField)
        
        currentLocationButton = UIButton(type: .system)
        currentLocationButton.size(size: .init(width: 312, height: 62))
        currentLocationButton.setTitleColor(UIColor(named: "White"), for: .normal)
        currentLocationButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        currentLocationButton.backgroundColor = UIColor(named: "Blue")
        currentLocationButton.layer.cornerRadius = 8
        currentLocationButton.clipsToBounds = true
        self.addSubview(currentLocationButton)
        currentLocationButton.setTitle("Use my current location", for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalToSystemSpacingBelow: self.safeAreaLayoutGuide.topAnchor, multiplier: 10),
            cityTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: self.safeAreaLayoutGuide.centerXAnchor, multiplier: 1),
            cityTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
        
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentLocationButton.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            currentLocationButton.centerXAnchor.constraint(equalToSystemSpacingAfter: self.centerXAnchor, multiplier: 1)
        ])
    }
    
}
