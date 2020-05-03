//
//  Instruction.swift
//  noise-camo-app
//
//  Created by Sarah Dreischer on 27/04/2020.
//  Copyright © 2020 Sarah Dreischer. All rights reserved.
//

import SwiftUI

struct Instruction: View {
    
    var body: some View {
        VStack() {
            HStack {
                Text("Instructions")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.leading, 20)
                Spacer()
            }
            
            Text("Welcome, please enable Bluetooth")
                .padding()
        
            Spacer()
        }
    }
}

struct Instruction_Previews: PreviewProvider {
    static var previews: some View {
        Instruction()
    }
}
