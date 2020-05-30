//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var setupPresent: Bool = false
    
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {        
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Image(systemName: "headphones")
                    .font(.system(size: 80,
                                  weight: .light))
                    .foregroundColor(.white)
                    .brightness(0.1)
                    .padding(.top, -20)
                    .padding(.trailing, 30)
                
                VStack(alignment: .leading) {
                    Image(systemName: "battery.25")
                        .font(.system(size: 25,
                                      weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    Text("25%")
                        .font(.system(size: 20,
                                      weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
            }.frame(height: screenHeight/6)
            
            Button(action: {
                self.setupPresent = true
            }) {
                ConnectEarphonesButton()
            }
            
            PageButtons(viewRouter: self.viewRouter)
                .frame(width: UIScreen.main.bounds.width - 30)
            
            Spacer()
        }.sheet(isPresented: self.$setupPresent) {
            BluetoothSetup(bluetoothManager: self.bluetoothManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            Home(viewRouter: ViewRouter())
        }
    }
}

struct HomeButton: View {
    let backgroundColor: Color
    let navigateToView: String
    let imageName: String
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        Button(action: {
            self.viewRouter.currentView = self.navigateToView
        }) {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: imageName)
                        .font(.system(size: 30,
                                      weight: .regular))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                        .shadow(radius: 5)
                    
                    Text(self.navigateToView.uppercased())
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height/8)
            .background(backgroundColor)
            .cornerRadius(8)
        }
    }
}
