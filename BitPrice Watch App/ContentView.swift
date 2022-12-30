//
//  ContentView.swift
//  BitPrice Watch App
//
//  Created by 澤野令 on 2022/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bitCoin = BitCoin()
    
    var body: some View {
        VStack {
            Image("BitCoin")
                .resizable()
                .frame(width: 130.0, height: 130.0)
                .padding(.bottom, -18)
            Text(bitCoin.priceLabel)
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Text(bitCoin.updatingLabel)
        }
        .padding()
        .onAppear{
            bitCoin.getPrice()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
