//
//  DataProvider.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import Foundation

class MainScreenViewModel {
    
    let networkManager = NetworkManager()
    
    // MARK: - Get data from network manager
    
    func fetchData(longitude: Double, latitude: Double, callBack: @escaping (_ weatherData: WeatherDataResult?, _ error: String?) -> Void) {
        
        networkManager.fetchData(longitude: longitude, latitude: latitude) { data, error in
            
            if error != nil {
                callBack(nil, error)
            } else {
                callBack(data, nil)
            }
        }
    }
}
