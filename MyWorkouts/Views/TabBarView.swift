import SwiftUI

enum Tabs {
    case workouts, settings, search, exercise
}

struct TabBarView: View {
    @Environment(\.modelContext) private var context
    @State var selectedTabs: Tabs = .workouts
    
    var body: some View {
        TabView(selection: $selectedTabs) {
            Tab("Workouts", systemImage: "list.bullet.rectangle.fill", value: .workouts) {
                WorkoutsView()
            }
            Tab("Exercises", systemImage: "dumbbell", value: .exercise) {
                ExerciseView(context: context)
            }
            Tab("Settings", systemImage: "gearshape", value: .settings) {
                SettingsView()
            }
            Tab(value: .search, role: .search) {
                SearchExerciseView()
            }
        }
        .tint(Color.indigo)
        .animation(.easeInOut, value: selectedTabs)
    }
}

#Preview {
    TabBarView()
}
