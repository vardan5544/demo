//
//  WeatherList.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import UIKit

class WeatherList: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    // Jamanak chunei aranc unwrap anelu sarqei)
    
    // MARK: - Setup Weather Data Function
    
    func setupData(data: WeatherDataResult, index: Int) {
        
        guard let dataList = data.list else { return }
        
        weatherImage.image = UIImage(named: dataList[index].weather.first!.icon!)
        temperatureLabel.text = String(NSString(format:"%.2f", ( (dataList[index].main?.temp)!))) + "\u{2103}"
        cloudyLabel.text = "Wind speed \(String(describing: dataList[index].wind!.speed!)) S"
        feelsLikeLabel.text = dataList[index].dt_txt ?? ""
    }
}
