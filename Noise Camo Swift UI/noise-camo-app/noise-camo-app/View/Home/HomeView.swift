//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @ObservedObject var viewRouter: ViewRouter
//    @ObservedObject var bluetoothManager = BluetoothManager()
//    @State private var setupPresent: Bool = false
    
    var body: some View {        
        VStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                Image("earphone-background1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height/3.5)
                    .opacity(0.9)
                    .clipShape(Corners(corner: [.bottomLeft, .bottomRight], size: CGSize(width: 25, height: 25)))
                VStack {
                    TopBarView(viewRouter: viewRouter).offset(y: -30)
                    HStack {
                        BatteryView().scaleEffect(0.7)
                        Spacer()
                    }
                    .padding([.leading, .bottom], 10)
                }
            }
            NavigatorButtonsView(bluetoothManager: self.bluetoothManager, viewRouter: self.viewRouter)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
//        .sheet(isPresented: self.$setupPresent) {
//            BluetoothSetup(bluetoothManager: self.bluetoothManager)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            HomeView(bluetoothManager: BluetoothManager(), viewRouter: ViewRouter())
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
