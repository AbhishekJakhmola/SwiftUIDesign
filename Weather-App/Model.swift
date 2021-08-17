//
//  Model.swift
//  Weather-App
//
//  Created by Cynoteck6 on 6/21/21.
//  Copyright © 2021 Cynoteck6. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let coord: Coord
        struct Coord: Codable {
            let lon, lat: Double
        }
    
    let weather: [Weather]
        struct Weather: Codable {
            let id: Int
            let main, description, icon: String
        }
    
    let base: String
    let main: Main
        struct Main: Codable {
            let temp, feels_like, temp_min, temp_max: Double
            let pressure, humidity, sea_level, grnd_level: Int
        }
    
    let visibility: Int
    let wind: Wind
        struct Wind: Codable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
    
    let clouds: Clouds
        struct Clouds: Codable {
            let all: Int
        }
    
    let dt: Int
    let sys: Sys
        struct Sys: Codable {
            let country: String
            let sunrise, sunset: Int
        }
    
    let timezone, id: Int
    let name: String
    let cod: Int
}











