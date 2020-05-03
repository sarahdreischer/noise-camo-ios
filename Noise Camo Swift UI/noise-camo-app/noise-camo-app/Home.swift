//
//  ContentView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var equalizerButtonPressed = false
    
    static let gradientPoint1 = Color(red: 0.44, green: 0.44, blue: 0.44, opacity: 1.0)
    static let gradientPoint2 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0.77)
    static let gradientPoint3 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0.18)
    static let gradientPoint4 = Color(red: 0.77, green: 0.77, blue: 0.77, opacity: 0)
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Rectangle()
                    .fill(LinearGradient(
                        gradient: .init(colors: [Self.gradientPoint1, Self.gradientPoint2, Self.gradientPoint3, Self.gradientPoint4]),
                    startPoint: .init(x: 0.5, y: 0),
                    endPoint: .init(x: 0.5, y: 1)))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Self.gradientPoint4, Self.gradientPoint3, Self.gradientPoint2, Self.gradientPoint1]),
                startPoint: .init(x: 0.5, y: 0),
                endPoint: .init(x: 0.5, y: 1)))
                .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    
                    NavigationLink(destination: EqualizerView()) {
                        EqualizerButtonView()
                            .foregroundColor(.black)
                    }
                    
                    NavigationLink(destination: Instruction()) {
                        EqualizerButtonView()
                            .foregroundColor(.black)
                    }
                    
                    NavigationLink(destination: Instruction()) {
                        EqualizerButtonView()
                            .foregroundColor(.black)
                    }
                    
                    
                    
                    Spacer()
                    
                }
            }
            .navigationBarItems(leading:
                HStack {
                    Text("NOISE")
                        .fontWeight(.regular)
                    
                    Text("CAMO")
                    .fontWeight(.medium)
                }.font(.title),
            trailing:
                HStack {
                    NavigationLink(destination: EqualizerView()) {
                       Image(systemName: "person.circle")
                        .font(.system(size: 30, weight: .regular))
                        .padding(.trailing, 20)
                        .foregroundColor(.black)
                    }
            })
        }
    
        
//        NavigationView {
//            VStack {
//                Image("earphone-background1")
//                    .cornerRadius(10)
//                    .padding(.top, 10)
//
//                NavigationLink(destination: Instruction(), tag: 1, selection: $selection) {
//                    Button(action: {
//                        print("Instructions tapped")
//                        self.selection = 1
//                    }) {
//                        HStack {
//                            Spacer()
//                            Text("Instructions")
//                                .foregroundColor(.white)
//                                .bold()
//                            Spacer()
//                        }
//                    }
//                    .accentColor(.black)
//                    .padding()
//                    .background(Color(UIColor.darkGray))
//                    .cornerRadius(4.0)
//                    .padding(.vertical, 20)
//                }
//                Spacer()
//                .navigationBarTitle("Home")
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
