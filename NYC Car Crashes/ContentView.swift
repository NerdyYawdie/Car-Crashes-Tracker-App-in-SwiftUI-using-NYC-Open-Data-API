//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CrashesView()
                .tabItem {
                    VStack {
                        Image(systemName: "car")
                        
                        Text("Crashes")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
