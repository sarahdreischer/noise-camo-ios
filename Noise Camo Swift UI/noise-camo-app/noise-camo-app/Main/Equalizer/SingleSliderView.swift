//
//  SingleSliderView.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/06/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct SingleSliderView: View {
    @Binding var currentValue: Float
    
    let label: String
    
    var body: some View {
        VStack {
            Text("+10dB")
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    
                    self.sliderBar(height: geometry.size.height)
                    
                    self.sliderCircle
                        .offset(y: geometry.size.height * CGFloat( -1 * self.currentValue))
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged{ value in
                                self.currentValue = self.clampSliderValue(
                                    yOffset: value.location.y,
                                    height: geometry.size.height)
                            }
                    )
                    
                    
                }
            }
            
            Text("-10dB")
                .foregroundColor(.white)
                .padding(.top, 5)
            
            Text(label).foregroundColor(.gray)
        }.font(.custom("Avenir", size: 10))
    }
    
    private func clampSliderValue(yOffset: CGFloat, height: CGFloat) -> Float {
        let offset = -1 * yOffset
        let factor = Float(offset / height)
        print("height: \(height) + offset: \(offset) + factor \(factor) + round factor \(getFixedValue(factor))")
        return (offset <= height && offset >= 0) ? factor : getFixedValue(factor)
    }
    
    private func getFixedValue(_ factor: Float) -> Float{
        return (factor < 0) ? 0 : 1
    }
}

struct SingleSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            SingleSliderView(
                currentValue: Binding.constant(0.5),
                label: "test")
        }
    }
}

private extension SingleSliderView {
    func sliderBar(height: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 1)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 1, height: height * CGFloat(self.currentValue))
        }
    }
    
    var sliderCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 5)
            Circle()
                .fill(Color.black)
        }
        .frame(width: 15, height: 15)
    }
}
