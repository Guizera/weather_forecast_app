//
//  WeatherViewController.swift
//  weather_forecast_app
//
//  Created by José Alves da Cunha on 22/11/21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    var selectedCity: CLPlacemark!
    var topContainerView: CurrentWeatherView!
    var bottomContainerView: ForecastWeatherView!
    var backgroundImageView: UIImageView!
    
    var progressIndicator: UIActivityIndicatorView!
    var locationManager: CLLocationManager!
    var weatherViewModel = WeatherViewModel()
    var forecastViewModel = ForecastViewModel()
    
    fileprivate func setupTopContainer() {
        
        topContainerView = CurrentWeatherView()
        topContainerView.selectCityButton.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        view.addSubview(topContainerView)
        
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 0),
            topContainerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0),
            topContainerView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0),
            topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
    
    fileprivate func setupBottomContainer() {
        
        bottomContainerView = ForecastWeatherView()
        view.addSubview(bottomContainerView)
        
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    fileprivate func setupIndicator() {
        
        progressIndicator = UIActivityIndicatorView()
        progressIndicator.center = self.view.center
        self.view.addSubview(progressIndicator)
        progressIndicator.style = .medium
        progressIndicator.color = .black
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
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        view.addSubview(blurEffectView)
        
        if isFirstLaunch() {
            //select City
            selectCity()
            UserDefaults.standard.set(true, forKey: "hasLaunchedPreviously")
        }
        
        setupTopContainer()
        setupBottomContainer()
        setupIndicator()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest

            locationManager.requestLocation()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if weatherViewModel.currentWeather == nil || forecastViewModel.currentForecast == nil {
            emptyUI()
        }
    }
    
    func emptyUI() {
        topContainerView.isHidden = true
        bottomContainerView.isHidden = true
        progressIndicator.startAnimating()
        
    }
    
    @objc func selectCity() {
        
        let selectCityVC = SelectCityViewController()
        selectCityVC.delegate = self
        selectCityVC.view.backgroundColor = .systemBackground
        self.navigationController?.pushViewController(selectCityVC, animated: isFirstLaunch() ? false : true)
        selectCityVC.navigationController?.navigationBar.isHidden = isFirstLaunch() ? true : false
    }
    
    func refreshWeatherUIState() {
        
        if weatherViewModel.currentWeather != nil {
            
            topContainerView.tempLabel.text = "\(round(10*weatherViewModel.getCurrentTempInCelsius()!)/10) °c"
            topContainerView.minTempLabel.text = "\(round(10*weatherViewModel.getMinTempInCelsius()!)/10) °c"
            topContainerView.maxTempLabel.text = "\(round(10*weatherViewModel.getMaxTempInCelsius()!)/10) °c"
            topContainerView.weatherDescriptionLabel.text = weatherViewModel.getWeatherDescription()?.capitalized
            topContainerView.weatherImageView.downloadWeatherImage(imgId: weatherViewModel.getWeatherIcon()!)
            topContainerView.selectCityButton.isHidden = false
            
            weatherViewModel.getReverseGeoCode { (placemark) in
                
                DispatchQueue.main.async {
                    self.topContainerView.cityLabel.text = placemark?.locality
                    self.topContainerView.isHidden = false
                    self.progressIndicator.stopAnimating()
                }
            }
        }
    }
    
    func refreshForecastUIState() {
        
        for i in 0..<forecastViewModel.getFollowingFiveDays().count {
            let view = bottomContainerView.daysViews[i]
            view.dayLabel.text = forecastViewModel.getFollowingFiveDays()[i]
            view.forecastDetailLabel.text = forecastViewModel.getHighLowForFollowingFiveDays()[i]
            
            
            var weatherConditionImageId = forecastViewModel.getAvgWeatherConditionImageStringsForFiveDays()[i]
            weatherConditionImageId+="d"
            view.forecastImageView.downloadWeatherImage(imgId: weatherConditionImageId)
        }
        bottomContainerView.isHidden = false
    }
    
    func isFirstLaunch() -> Bool {
        return !UserDefaults.standard.bool(forKey: "hasLaunchedPreviously")
    }
    
}
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let latitude = "\(locations.first!.coordinate.latitude)"
        let longitude = "\(locations.first!.coordinate.longitude)"
        
        weatherViewModel.refreshWeather(params: ["latitude": latitude,"longitude": longitude]) {
            
            DispatchQueue.main.async {
                self.refreshWeatherUIState()
            }
        }
        
        forecastViewModel.refreshWeatherForecast(params: ["latitude": latitude,"longitude": longitude]) {
           
            DispatchQueue.main.async {
                self.refreshForecastUIState()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
extension WeatherViewController: SelectCityDelegate {
    
    func onSelectCity(placemark: CLPlacemark) {
        
        self.selectedCity = placemark
        
        let latitude = "\(placemark.location!.coordinate.latitude)"
        let longitude = "\(placemark.location!.coordinate.longitude)"
        
        weatherViewModel.refreshWeather(params: ["latitude": latitude,"longitude": longitude]) {
            
            DispatchQueue.main.async {
                self.refreshWeatherUIState()
            }
        }
        
        forecastViewModel.refreshWeatherForecast(params: ["latitude": latitude,"longitude": longitude]) {
           
            DispatchQueue.main.async {
                self.refreshForecastUIState()
            }
        }
    }
}
extension UIImageView {
    
    func downloadWeatherImage(imgId: String) {
        
        let imgUrlString = "https://openweathermap.org/img/wn/\(imgId)@2x.png"
        print(imgUrlString)
        
        guard let imgUrl = URL(string: imgUrlString) else {return}
        
        URLSession.shared.dataTask(with: imgUrl) { (data, _, _) in
            
            guard let imgData = data else {return}
            
            guard let img = UIImage(data: imgData) else {return}
            
            DispatchQueue.main.async {
                self.image = img
            }
        }.resume()
    }
}
