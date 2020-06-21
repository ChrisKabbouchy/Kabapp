//
//  ButtomView.swift
//  Kabapp SwiftUI
//
//  Created by Christian Kabouchy on 6/21/20.
//  Copyright © 2020 Christian Kabouchy. All rights reserved.
//

import SwiftUI

struct bottomView: View {
    var body: some View {
        HStack{
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "arrowshape.turn.up.right.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "multiply.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.red)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
        }.padding()
    }
}
struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        bottomView()
    }
}
