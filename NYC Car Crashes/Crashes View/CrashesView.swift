//

import SwiftUI

struct CrashesView: View {
    
    @StateObject var viewModel = CrashesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !viewModel.crashes.isEmpty {
                    List(viewModel.crashes) { crash in
                        NavigationLink {
                            CrashDetailView(crash: crash)
                        } label: {
                            CrashRowView(viewModel: CrashRowViewModel(crash: crash))
                        }

                    }
                } else {
                    ContentUnavailableView("No Crashes Found", systemImage: "car", description: Text("Please Retry and check your internet connection."))
                }
                
            }
            .navigationTitle(Text("Crashes"))
            .task {
                await viewModel.fetchCrashes()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView(LocalizedStringKey("Fetching Crashes..."))
                }
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text(viewModel.errorMessage))
            }
            .refreshable {
                await viewModel.fetchCrashes()
            }
        }
    }
}

#Preview {
    CrashesView()
}
