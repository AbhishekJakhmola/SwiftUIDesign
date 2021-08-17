//
//  DisplayDetails.swift
//  Weather-App
//
//  Created by Cynoteck6 on 6/21/21.
//  Copyright © 2021 Cynoteck6. All rights reserved.
//

import SwiftUI
/*---------------------------------------------------------------------
 Networking Section with generic api management
---------------------------------------------------------------------*/
class networking: ObservableObject {
    
    @Published var desc:String
    @Published var tempMin:Double
    @Published var tempMax:Double
    @Published var humidity:Int
    @Published var windSpeed:Double
    
    init() {
        self.desc = "desc"
        self.tempMin = 0.0
        self.tempMax = 0.0
        self.humidity = 0
        self.windSpeed = 0.0
    }
    
    func getJsonData(cityName: String , apiString: String , completionHandler: @escaping (Data,Bool) -> Void){
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiString)") {
            do{
                let task = URLSession.shared.dataTask(with: url) { (data , response , error) -> Void in
                    if error != nil {
                        completionHandler(data!,true)
                    }
                    else if error == nil {
                        completionHandler(data!,false)
                    }
                }
                task.resume()
            }
        }
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        guard let jsonResponse = try? decoder.decode(Welcome.self, from: json) else {
            fatalError("Something went wrong.")
        }
        self.desc = jsonResponse.weather[0].description
        self.tempMin = jsonResponse.main.temp_min
        self.tempMax = jsonResponse.main.temp_max
        self.humidity = jsonResponse.main.humidity
        self.windSpeed = jsonResponse.wind.speed
        print(jsonResponse)
    }
}

/*---------------------------------------------------------------------
 Storing information inside a defined class.
---------------------------------------------------------------------*/
class store: ObservableObject{
    var desc:String = ""
    var tempMin:Double = 0.0
    var tempMax:Double = 0.0
    var humidity:Int = 0
    var windSpeed:Double = 0.0
}
/*---------------------------------------------------------------------
 DisplayDetails view to display the information.
---------------------------------------------------------------------*/

struct DisplayDetails: View {
    @ObservedObject var networkingObj = networking()
    @ObservedObject var storeObj = store()
    @State private var apiString = "07bb9bd41c278f77c29cd65f6633934e"
    @State private var desc = ""
    var cityName:String
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all).onAppear{self.networkingObj.getJsonData(cityName: self.cityName, apiString: self.apiString, completionHandler: { data , isError in
                    if !isError{
                        print(data)
                        self.networkingObj.parse(json: data)
//                        print(self.networkingObj.desc)
                    }
                })}
            VStack(spacing: 40){
                Spacer()
                HStack{
                    Text("\(cityName)'s will have")
                        .font(.system(size: 20, weight: .medium , design:.default))
                        .foregroundColor(.black)
                    Text(networkingObj.desc.uppercased())
                    .font(.system(size: 32, weight: .medium , design:.default))
                    .foregroundColor(.white)
                }
                HStack{
                    VStack{
                        Text("Tempeature(°C)").font(.system(size: 20, weight: .medium , design:.default))
                        .foregroundColor(.black)
    
                        HStack(spacing:40){
                            Text("\((networkingObj.tempMin - 273.15), specifier: "%.2f")")
                            .font(.system(size: 32, weight: .medium , design:.default))
                            .foregroundColor(.white)
                            Text("\((networkingObj.tempMax - 273.15), specifier: "%.2f")")
                            .font(.system(size: 32, weight: .medium , design:.default))
                            .foregroundColor(.white)
                        }
                    }
                }
                HStack{
                    Text("Humidity").font(.system(size: 20, weight: .medium , design:.default))
                    .foregroundColor(.black)
                    Text("\(String(networkingObj.humidity)) gpmc")
                    .font(.system(size: 32, weight: .medium , design:.default))
                    .foregroundColor(.white)
                }
                HStack{
                    Text("WindSpeed").font(.system(size: 20, weight: .medium , design:.default))
                    .foregroundColor(.black)
                    Text("\(String(networkingObj.windSpeed)) mps")
                    .font(.system(size: 32, weight: .medium , design:.default))
                    .foregroundColor(.white)
                }
                Spacer()
            }
        }
    }

}

struct DisplayDetails_Previews: PreviewProvider {
    static var previews: some View {
        DisplayDetails(cityName: "Dehradun")
    }
}

