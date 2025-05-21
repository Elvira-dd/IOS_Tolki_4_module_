//
//  AboutView.swift
//  Tolki
//
//  Created by Эльвира on 12.11.2024.
//

import SwiftUI
import MapKit

struct AboutView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.790278, longitude: 37.700278), // МГУ ВШЭ Москва, пример
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("О приложении Tolki")
                    .font(.title)
                    .bold()
                
                Text("Это приложение для подкастов от команды ВШЭ. Контакты: team@tolki.app")
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(spacing: 40) {
                    Link("Сайт", destination: URL(string: "https://tolki.app")!)
                    Link("Лэндинг", destination: URL(string: "https://landing.tolki.app")!)
                }
                .font(.headline)
                
                Text("Наш офис:")
                    .font(.headline)
                    .padding(.top)
                
                Map(coordinateRegion: $region, annotationItems: [OfficeLocation()]) { location in
                    MapMarker(coordinate: location.coordinate, tint: .red)
                }
                .frame(height: 300)
                .cornerRadius(10)
                .padding()
            }
            .padding()
        }
    }
}

struct OfficeLocation: Identifiable {
    let id = UUID()
    let coordinate = CLLocationCoordinate2D(latitude: 55.790278, longitude: 37.700278) // Координаты Вышки
}
