//
//  CurrentWeatherView.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 20/11/21.
//

import Foundation
import UIKit

class CurrentWeatherView: UIView {
    
    var tempLabel: UILabel!
    var minTempLabel: UILabel!
    var maxTempLabel: UILabel!
    var weatherDescriptionLabel: UILabel!
    var topContainerView: UIView!
    var bottomContainerView: UIView!
    var weatherImageView: UIImageView!
    var minMaxStackView: UIStackView!
    var cityLabel: UILabel!
    var selectCityButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topContainerView = self
        
        cityLabel = UILabel()
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 40.0)
        cityLabel.textColor = UIColor(named: "DarkBlue")
        topContainerView.addSubview(cityLabel)
        
        tempLabel = UILabel()
        tempLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 40.0)
        tempLabel.textColor = UIColor(named: "DarkBlue")
        topContainerView.addSubview(tempLabel)
        
        minTempLabel = UILabel()
        minTempLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
        maxTempLabel = UILabel()
        maxTempLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 15.0)
        
        minMaxStackView = UIStackView()
        topContainerView.addSubview(minMaxStackView)
        minMaxStackView.alignment = .center
        minMaxStackView.axis = .horizontal
        minMaxStackView.spacing = tempLabel.frame.width / 2
        minMaxStackView.distribution = .equalSpacing
        minMaxStackView.addArrangedSubview(minTempLabel)
        minMaxStackView.addArrangedSubview(maxTempLabel)
        topContainerView.addSubview(minMaxStackView)
        
        weatherDescriptionLabel = UILabel()
        topContainerView.addSubview(weatherDescriptionLabel)
        weatherDescriptionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)
        weatherDescriptionLabel.textColor = UIColor(named: "DarkBlue")
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.textAlignment = .center
        
        weatherImageView = UIImageView()
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.image = weatherImageView.image?.withRenderingMode(.alwaysTemplate)
        topContainerView.addSubview(weatherImageView)
        
        selectCityButton = UIButton(type: .system)
        selectCityButton.isHidden = true
        selectCityButton.tintColor = UIColor(named: "White")
        selectCityButton.size(size: .init(width: 50, height: 50))
        selectCityButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        topContainerView.addSubview(selectCityButton)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            cityLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: topContainerView.centerXAnchor, multiplier: 0),
            cityLabel.topAnchor.constraint(equalToSystemSpacingBelow: topContainerView.topAnchor, multiplier: 2),
            cityLabel.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalToSystemSpacingAfter: topContainerView.centerXAnchor, multiplier: 0),
            tempLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: topContainerView.centerYAnchor, multiplier: 0)
        ])
        minMaxStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minMaxStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: tempLabel.leadingAnchor, multiplier: 0),
            minMaxStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: tempLabel.trailingAnchor, multiplier: 0),
            minMaxStackView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: minMaxStackView.leadingAnchor, multiplier: 0),
            weatherDescriptionLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: minMaxStackView.trailingAnchor, multiplier: 0),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: minMaxStackView.bottomAnchor, constant: 20)
        ])
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImageView.centerXAnchor.constraint(equalToSystemSpacingAfter: tempLabel.centerXAnchor, multiplier: 0),
            weatherImageView.widthAnchor.constraint(equalTo: cityLabel.widthAnchor),
            weatherImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: tempLabel.topAnchor)
        ])
        
        selectCityButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectCityButton.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 5),
            selectCityButton.centerYAnchor.constraint(equalToSystemSpacingBelow: cityLabel.centerYAnchor, multiplier: 0),
            selectCityButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
