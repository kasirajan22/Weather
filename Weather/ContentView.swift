//
//  ContentView.swift
//  Weather
//
//  Created by Magizhan on 17/10/20.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var weatherManager = WeatherManager.shared
    @State private var location: String = ""
    @State private var temprature: String = "27"
    @State private var image: String = "sun.max"
    @State private var city: String = "Londan"
    
    var body: some View {
        VStack{
            
            HStack(spacing: 10, content: {
                Image(systemName: "location.circle.fill")
                    .font(.title)
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        weatherManager.startUpdating()
                    })
                
                TextField("Search..", text: $location)
                    .frame(height: 30)
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(Color("color"))
                    .multilineTextAlignment(.trailing)
                    
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        weatherManager.fetchWeather(cityName: location)
                        location = ""
                    })
            })
            .padding()
            .padding(.top, 20)
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 10, content: {
                    Image(systemName: weatherManager.image)
                        .font(.system(size: 100))
                    HStack(alignment: .center, spacing: 1, content: {
                        Text(weatherManager.temprature)
                            .font(.system(size: 60))
                            .font(.title)
                            .fontWeight(.heavy)
                        VStack {
                            Text("0")
                                .font(.system(size: 20))
                                .font(.title)
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        Text("C")
                            .font(.system(size: 60))
                            .font(.title)
                            .fontWeight(.light)
                        
                       
                    })
                    .frame(height: 55)
                    
                    Text(weatherManager.cityName)
                        .font(.system(size: 30))
                        .font(.title)
                        .fontWeight(.light)
                })
                .padding()
            }
            
            Spacer()
        }
        .background(
            Image("background")
                .resizable()
                .scaledToFill()
        )
        .alert(isPresented: $weatherManager.showError, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text(weatherManager.errorMsg), dismissButton: .default(Text("Got it!")))
        })
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
