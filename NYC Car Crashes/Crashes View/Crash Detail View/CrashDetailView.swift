//
import MapKit
import SwiftUI

struct CrashDetailView: View {
    
    let crash: Crash
    
    var body: some View {
        VStack {
            
            mapView
            
            Form {
                
                Section {
                    if let crashDate = crash.convetDate() {
                        Text(crashDate, style: .date)
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("Date")
                }

                Section {
                    Text(crash.vehicle_type_code1 ?? "")
                    
                    Text(crash.contributing_factor_vehicle_1 ?? "")
                } header: {
                    Text("Vehicle 1")
                }

                
                if let vehicleType = crash.vehicle_type_code2,
                   let contributing_factor_vehicle_2 = crash.contributing_factor_vehicle_2 {
                    Section {
                        Text(vehicleType)
                        
                        Text(contributing_factor_vehicle_2)
                    } header: {
                        Text("Vehicle 2")
                    }
                }
                
            }
        }
        .navigationTitle(Text(crash.on_street_name ?? ""))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var mapView: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(crash.latitude ?? "") ?? 0.0, longitude: Double(crash.longitude ?? "") ?? 0.0), latitudinalMeters: .zero, longitudinalMeters: .zero)), interactionModes: .zoom)
            .frame(height: 300)
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        CrashDetailView(crash: Crash(crash_date: "2021-09-11T00:00:00.000", on_street_name: "WHITESTONE EXPRESSWAY", contributing_factor_vehicle_1: "Aggressive Driving/Road Rage", contributing_factor_vehicle_2: "Unspecified", vehicle_type_code1: "Sedan", vehicle_type_code2: "Sedan", latitude: "40.82463", longitude: "-73.85565"))
    }
}
