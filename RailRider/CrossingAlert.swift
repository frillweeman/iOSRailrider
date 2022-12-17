//
//  CrossingAlert.swift
//  RailRider
//
//  Created by Will Freeman on 12/16/22.
//

import SwiftUI

struct CrossingAlert: View {
    var body: some View {
        Label("Upcoming Crossing", systemImage: "road.lanes")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)
            .padding()
            .background(.orange)
            .clipShape(Capsule())
            .shadow(radius: 3)
    }
}

struct CrossingAlert_Previews: PreviewProvider {
    static var previews: some View {
        CrossingAlert()
    }
}
