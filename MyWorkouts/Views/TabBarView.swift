import SwiftUI

enum Tabs {
    case workouts, newWorkout, search, exercise
}

struct TabBarView: View {
    @State var selectedTabs: Tabs = .workouts
    
    var body: some View {
        TabView(selection: $selectedTabs) {
            Tab("Workouts", systemImage: "list.bullet.rectangle.fill", value: .workouts) {
                WorkoutsView()
            }
            Tab("New Workout", systemImage: "plus.square.on.square", value: .newWorkout) {
                NewWorkoutView()
            }
            Tab("Exercises", systemImage: "dumbbell", value: .exercise) {
                ExerciseView()
            }
            Tab(value: .search, role: .search) {
                SearchExerciseView()
            }
        }
    }
}

#Preview {
    TabBarView()
}
