//
//  MainScreen.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import UIKit

class MainScreen: UIViewController {
    
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var cloudyCurrent: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherCurrentDayItem: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var feelsLikeCurrent: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    
    private let viewModel = MainScreenViewModel()
    private var data: WeatherDataResult?
    private let myLong = 44.503490
    private let myLat = 40.177200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        fetchData(longitude: myLong, latitude: myLat)
        setupTableView()
    }
    
    // MARK: - Get Data
    
    private func fetchData(longitude: Double, latitude: Double) {
        
        viewModel.fetchData(longitude: longitude, latitude: latitude) { [weak self] weatherData, error in
            
            guard let self = self else { return }
            
            if error != nil {
                
                self.showAlert(title: "Error", message: error ?? "")
            } else {
                
                if let weatherData = weatherData {
                    
                    self.data = weatherData
                    self.countryLabel.text = self.data?.city?.name
                    
                    if let imageName = weatherData.list?.first?.weather.first?.icon {
                        self.weatherCurrentDayItem.image = UIImage(named: imageName)
                    }
                    
                    if let temp = weatherData.list?.first?.main?.temp {
                        self.currentTemperature.text = String(NSString(format:"%.2f", temp)) + "\u{2103}"
                    }
                    
                    if let cloudy = weatherData.list?.first?.weather.first?.main {
                        self.cloudyCurrent.text = cloudy
                    }
                    
                    if let feelsLike = weatherData.list?.first?.main?.feels_like {
                        self.feelsLikeCurrent.text = "Feels like " + String(NSString(format:"%.2f", feelsLike)) + "\u{2103}"
                    }
                    
                    self.weatherTableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Show Alert
    
    private func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Config TextField Delegate
    
    private func setupTextField() {
        
        longitude.delegate = self
        latitude.delegate = self
    }
    
    // MARK: - Update Weather Location
    
    private func setCoord() {
        
        if longitude.text != nil && longitude.text != "" && latitude.text != nil && latitude.text != "" {
            
            if !(latitude.text?.contains(","))! && !(longitude.text?.contains(","))! {
                
                let longText: Double = Double(longitude.text!) ?? myLong
                let latText: Double = Double(latitude.text!) ?? myLat
                
                fetchData(longitude: longText, latitude: latText)
            }
        } else {
            fetchData(longitude: myLong, latitude: myLat)
        }
    }
    
    // MARK: - Config Table View Delegate and DataSource
    
    private func setupTableView() {
        weatherTableView.register(UINib(nibName: "WeatherList", bundle: .main), forCellReuseIdentifier: "cell")
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
    }
}

// MARK: -  EXTENSIONS

// Table View
extension MainScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let data = data else { return 0 }
        guard let dataList = data.list else { return 0 }
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = data else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? WeatherList
        
        cell?.setupData(data: data, index: indexPath.row)
        
        return cell!
    }
}

// Text Field
extension MainScreen: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        longitude.resignFirstResponder()
        latitude.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        setCoord()
        return true
    }
}
