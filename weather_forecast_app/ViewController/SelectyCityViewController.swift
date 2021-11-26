//
//  SelectyCityViewController.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 22/11/21.
//

import Foundation
import CoreLocation
import UIKit

protocol SelectCityDelegate: AnyObject {
    
    func onSelectCity(placemark: CLPlacemark)
}


class SelectCityViewController: UIViewController, UITextFieldDelegate {
    
    weak var delegate: SelectCityDelegate!
    var locationManager: CLLocationManager!
    
    var selectCityView: SelectCityView!
    var backgroundImageView: UIImageView!
    
    fileprivate func setupSelectCityView() {
        
        selectCityView = SelectCityView()
        view.addSubview(selectCityView)
        selectCityView.cityTextField.delegate = self
        selectCityView.currentLocationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
        
        selectCityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectCityView.topAnchor.constraint(equalTo: view.topAnchor),
            selectCityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectCityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectCityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        setupSelectCityView()
        
        self.navigationItem.title = "Select your city"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.alpha = 0.9
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let adress = selectCityView.cityTextField.text else { return false }
        
        CLGeocoder().geocodeAddressString(adress) { (placemarks, error) in
            
            guard let placemark = placemarks?.first else { return }
            self.delegate?.onSelectCity(placemark: placemark)
            
        }
        textField.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
        
        return true
        
    }
    
    @objc func getCurrentLocation() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        
    }
}
extension SelectCityViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            guard let placemark = placemarks?.first else { return }
            
            self.delegate.onSelectCity(placemark: placemark)
            self.navigationController?.popViewController(animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
