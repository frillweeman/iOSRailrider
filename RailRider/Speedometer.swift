//
//  Speedometer.swift
//  RailRider
//
//  Created by Will Freeman on 12/16/22.
//

import SwiftUI

struct Speedometer: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text("57").lineLimit(1)
                .font(.system(size: 55, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 90, height: 90)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10
                    ).fill(Color(red: 0.2, green: 0.2, blue: 0.2)).shadow(radius: 3)
                )
                .padding(.top, 20)
                .padding(.trailing, 12)
            Text("60").lineLimit(1)
                .padding(10)
                .font(.system(size: 14, weight: .bold))
                .frame(width: 40, height: 40)
                .overlay(Circle().stroke(.red, lineWidth: 6))
                .background(Circle().fill(.white))
        }
    }
}

struct Speedometer_Previews: PreviewProvider {
    static var previews: some View {
        Speedometer()
    }
}
