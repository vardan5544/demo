//
//  NetworkManager.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private let BASE_URL = "http://api.openweathermap.org/data/2.5/forecast"
    private let API = "ff019c8d001f833b6c882292eab40900"
    private let ID = "524901"
    
// MARK: - Fetch Data From BackEnd
    
    func fetchData(longitude: Double, latitude: Double, callBack: @escaping (_ data: WeatherDataResult?, _ error: String?) -> Void) {
        
        let parameters: [String: Any] = [
            
            "appid": API,
            "id": ID,
            "lang": "en",
            "lat": latitude,
            "lon": longitude
        ]
        
        AF.request(BASE_URL, method: .get, parameters: parameters).responseData { response in
            
            switch response.result {
            case .success(let data):
                
                do {
                    let parsedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    let DataResult = WeatherDataResult(data: parsedData)
                    callBack(DataResult, nil)
                } catch let error {
                    callBack(nil, "\(error.localizedDescription)")
                }
                
            case .failure(let error):
                callBack(nil, error.localizedDescription)
            }
        }.resume()
    }
}
