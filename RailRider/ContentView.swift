//
//  ContentView.swift
//  RailRider
//
//  Created by Will Freeman on 11/8/22.
//

import SwiftUI
import MapKit

struct OSMRailway: Hashable, Codable {
    let name: String
    let id: Int
}

class RailwayModel: ObservableObject {
    @Published var nearbyRailways: [OSMRailway] = []
    
    public func fetchRailways() {
        guard let url = URL(string: "http://localhost:3000/nearestRailroad?coordinates=34.627103,-86.970355&radius=100") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to JSON
            do {
                let railways = try JSONDecoder().decode([OSMRailway].self, from: data)
                DispatchQueue.main.async {
                    self?.nearbyRailways = railways
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    @StateObject private var railwayModel = RailwayModel()
    @State private var currentRailway: OSMRailway?
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.initLocationManager()
                }
            VStack {
                if !railwayModel.nearbyRailways.isEmpty {
                    Picker("Subdivision", selection: $currentRailway) {
                        ForEach(railwayModel.nearbyRailways, id: \.self) { railway in
                            Label(railway.name, systemImage: "tram").tag(railway as OSMRailway?)
                        }
                    }.padding(10).background(.white).clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 3)
                } else {
                    Button("Find Nearby Railway", action: railwayModel.fetchRailways)
                        .buttonStyle(.borderedProminent)
                }
                Spacer()
                HStack {
                    Spacer()
                    Speedometer()
                        .padding(.trailing, 20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34, longitude: -86), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    func initLocationManager() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.activityType = .otherNavigation
            locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        } else {
            print("location services is disabled")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("go to settings")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let userLocation = locationManager.location else { return }
            region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
