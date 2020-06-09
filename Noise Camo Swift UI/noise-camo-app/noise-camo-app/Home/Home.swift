//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var setupPresent: Bool = false
    
    var body: some View {        
        VStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                Image("earphone-background1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.8)
                
                VStack {
                    TopBarView(viewRouter: viewRouter)
                    Spacer()
                    HStack {
                        BatteryView()
                        Spacer()
                    }.padding([.leading, .bottom], 10)
                }
            }
            .frame(height: UIScreen.main.bounds.height/2.8)
            .edgesIgnoringSafeArea(.all)
            
            
            Button(action: {
                self.setupPresent = true
            }) {
                ConnectEarphonesButton()
            }
            
            PageButtons(viewRouter: self.viewRouter)
                .frame(width: UIScreen.main.bounds.width - 30)
            
            Spacer()
        }
        .sheet(isPresented: self.$setupPresent) {
            BluetoothSetup(bluetoothManager: self.bluetoothManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            HomeView(viewRouter: ViewRouter())
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
