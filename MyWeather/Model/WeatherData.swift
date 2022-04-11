//
//  WeatherData.swift
//  MyWeather
//
//  Created by Hakobjanyan Vardan on 10.04.22.
//

import Foundation

struct Weather: Codable {
    
    var id: Int = 0
    var main: String = ""
    var description: String = ""
    var icon: String = ""
}

struct Main: Codable {
    
    var temp: Double = 0.0
    var feels_like: Double = 0.0
    var temp_min: Double = 0.0
    var temp_max: Double = 0.0
    var pressure: Int = 0
    var sea_level: Int = 0
    var grnd_level: Int = 0
    var humidity: Int = 0
    var temp_kf: Double = 0.0
}

struct Clouds: Codable {
    
    var all: Int = 0
}

struct Wind: Codable {
    
    var speed: Double = 0.0
    var deg: Int = 0
    var gust: Double = 0.0
}

struct Sys: Codable {
    
    var pod: String = ""
}

struct WeatherData: Codable {
    
    var cod: String = ""
    var message: Int = 0
    var cnt: Int = 0
    var list: [List] = [List()]
    var city: City = City()
}

struct List: Codable {
    
    var dt: Int = 0
    var main: Main = Main()
    var weather: [Weather] = []
    var clouds: Clouds = Clouds()
    var wind: Wind = Wind()
    var visibility: Int = 0
    var pop: Double = 0.0
    var sys: Sys = Sys()
    var dt_txt: String = ""
}

struct City: Codable {
    
    var id: Int = 0
    var name: String = ""
    var coord: Coord = Coord()
    var country: String = ""
    var population: Int = 0
    var timezone: Int = 0
    var sunrise: Int = 0
    var sunset: Int = 0
}

struct Coord: Codable {
    
    var lat: Double = 0.0
    var lon: Double = 0.0
}

