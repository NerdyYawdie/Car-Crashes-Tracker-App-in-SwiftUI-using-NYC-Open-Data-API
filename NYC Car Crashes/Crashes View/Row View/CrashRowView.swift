//
import MapKit
import SwiftUI

struct CrashRowView: View {
    
    let viewModel: CrashRowViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(viewModel.crash.vehicle_type_code1 ?? "")
                        .bold()
                        .lineLimit(2)
                    
                    Text(viewModel.crash.contributing_factor_vehicle_1 ?? "")
                        .lineLimit(1)
                        .padding(.bottom)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(viewModel.crash.vehicle_type_code2 ?? "")
                        .lineLimit(2)
                        .bold()
                    
                    Text(viewModel.crash.contributing_factor_vehicle_2 ?? "")
                        .lineLimit(1)
                        .padding(.bottom)
                    
                }
            }
            
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(viewModel.crash.latitude ?? "") ?? 0.0, longitude: Double(viewModel.crash.longitude ?? "") ?? 0.0), latitudinalMeters: .zero, longitudinalMeters: .zero)), interactionModes: .zoom)
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .cornerRadius(4)
            
            Text(viewModel.crash.on_street_name?.capitalized ?? "")
                .padding(.bottom, 5)
            
            if let crashDate = viewModel.convetDate() {
                Text(crashDate, style: .date)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
        }
    }
}

#Preview {
    CrashRowView(viewModel: CrashRowViewModel(crash: Crash(crash_date: "2021-09-11T00:00:00.000", on_street_name: "WHITESTONE EXPRESSWAY", contributing_factor_vehicle_1: "Aggressive Driving/Road Rage", contributing_factor_vehicle_2: "Unspecified", vehicle_type_code1: "Sedan", vehicle_type_code2: "Sedan", latitude: "40.82463", longitude: "-73.85565")))
        .padding()
}
