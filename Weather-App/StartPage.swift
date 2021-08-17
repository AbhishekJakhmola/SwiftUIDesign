//
//  ContentView.swift
//  Weather-App
//
//  Created by Cynoteck6 on 6/21/21.
//  Copyright © 2021 Cynoteck6. All rights reserved.
//

import SwiftUI

struct StartPage: View {
    
    @State private var selectedCity = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, Color("skyblue")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack{
                    Image(systemName: "sun.max.fill")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: 140,height: 140)
                    Spacer()
                    Text("Select Your City")
                            .font(.system(size: 32, weight: .medium , design:
                                .default))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 60,height: 60)
                    Spacer()
                    Picker(selection: $selectedCity, label: Text("")
                            .font(.system(size: 30, weight: .medium , design:
                                .default))
                                    .foregroundColor(.white)){
                                    Text("Dehradun").tag("Dehradun")
                                    Text("Delhi").tag("Delhi")
                                    Text("Mumbai").tag("Mumbai")
                                    Text("Chennai").tag("Chennai")
                                    Text("Kolkata").tag("Kolkata")
                                }.frame(width: 300)
                                .clipped()
                    Spacer()
                    NavigationLink(destination:DisplayDetails(cityName:selectedCity), label: { Text("Predict")
                        .frame(width:180,height:40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    })
                    Spacer()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}

