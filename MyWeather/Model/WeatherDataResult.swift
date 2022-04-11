//
//  WeatherDataResult.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import Foundation

struct WeatherDataResult {
    
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [ListResult]?
    var city: CityResult?
    
    init(data: WeatherData) {
        
        cod = data.cod
        message = data.message
        cnt = data.cnt
        
        var listDataResult = [ListResult]()
        
        for item in data.list {
            
            let data = ListResult(data: item)
            listDataResult.append(data)
        }
        
        list = listDataResult
        city = CityResult(data: data.city)
    }
}

struct CoordResult {
    
    var lat: Double?
    var lon: Double?
    
    init(coord: Coord) {
        lat = coord.lat
        lon = coord.lon
    }
}

struct ListResult {
    
    var dt: Int?
    var main: MainResult?
    var weather: [WeatherResult] = []
    var clouds: CloudsResult?
    var wind: WindResult?
    var visibility: Int?
    var pop: Double?
    var sys: SysResult?
    var dt_txt: String?
    
    init(data: List) {
        
        dt = data.dt
        main = MainResult(data: data.main)
        
        var weatherDataList: [WeatherResult] = []
        for item in data.weather {
            let weatherDataResult = WeatherResult(data: item)
            weatherDataList.append(weatherDataResult)
        }
        weather = weatherDataList
        clouds = CloudsResult(data: data.clouds)
        wind = WindResult(data: data.wind)
        visibility = data.visibility
        pop = data.pop
        sys = SysResult(data: data.sys)
        dt_txt = data.dt_txt
    }
}

struct CityResult {
    
    var id: Int?
    var name: String?
    var coord: CoordResult?
    var country: String?
    var population: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
    
    init(data: City) {
        
        id = data.id
        name = data.name
        coord = CoordResult(coord: data.coord)
        country = data.country
        population = data.population
        timezone = data.timezone
        sunrise = data.sunrise
        sunset = data.sunset
    }
}

struct WeatherResult {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init(data: Weather) {
        
        id = data.id
        main = data.main
        description = data.description
        icon = data.icon
    }
}

struct MainResult {
    
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var sea_level: Int?
    var grnd_level: Int?
    var humidity: Int?
    var temp_kf: Double?
    
    init(data: Main) {
        
        temp = data.temp - 273.15 // Convert Kelvin to Celsius
        feels_like = data.feels_like - 273.15 // Convert Kelvin to Celsius
        temp_min = data.temp_min
        temp_max = data.temp_max
        pressure = data.pressure
        sea_level = data.sea_level
        grnd_level = data.grnd_level
        humidity = data.humidity
        temp_kf = data.temp_kf
    }
}

struct CloudsResult {
    
    var all: Int?
    init(data: Clouds) {
        all = data.all
    }
}

struct WindResult {
    
    var speed: Double?
    var deg: Int?
    var gust: Double?
    
    init(data: Wind) {
        speed = data.speed
        deg = data.deg
        gust = data.gust
    }
}

struct SysResult {
    
    var pod: String?
    
    init(data: Sys) {
        pod = data.pod
    }
}
