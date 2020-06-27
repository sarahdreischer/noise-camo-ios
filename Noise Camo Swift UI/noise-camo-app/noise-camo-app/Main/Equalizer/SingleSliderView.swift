//
//  SingleSliderView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SingleSliderView: View {
    @Binding var percentage: Float
    
    let label: String
    
    var body: some View {
        VStack {
            Text("+10dB")
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 1)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 5)
                        Circle()
                            .fill(Color.black)
                    }
                    .frame(width: 15, height: 15)
                    .offset(y: geometry.size.height * CGFloat( -1 * self.percentage / 100))
                    .gesture(DragGesture()
                    .onChanged{ value in
                        self.percentage = Float((value.location.y / geometry.size.height) * 100)
                        print(self.percentage)
                    }
                    .onEnded{ value in
                        self.percentage = Float((value.location.y / geometry.size.height) * 100)
                        
                        print(self.percentage)
                        }
                    )
                    
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 1, height: geometry.size.height * CGFloat(self.percentage / 100))
                }
            }
            
            Text("-10dB")
                .foregroundColor(.white)
                .padding(.top, 5)
            
            Text(label).foregroundColor(.gray)
        }.font(.custom("Avenir", size: 10))
    }
}

struct SingleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SingleSliderView(
                percentage: Binding.constant(50),
                label: "test")
        }
    }
}
