import SwiftUI

struct SettingsView: View {
    @AppStorage("preferredUnit") private var preferredUnit: String = "kg"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Preferences")) {
                    Picker("Units", selection: $preferredUnit) {
                        Text("Kilograms (kg)").tag("kg")
                        Text("Pounds (lbs)").tag("lbs")
                    }
                }

                Section(header: Text("Statistics")) {
                    NavigationLink("View Statistics") {
                        ExerciseListView()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
