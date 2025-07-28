import SwiftUI
import SwiftData

struct WorkoutDetailsView: View {
    @Bindable var workout: Workout

    var body: some View {
        Form {
            Section(header: Text("Info")) {
                TextField("Title", text: $workout.name)
                DatePicker("Date", selection: $workout.date, displayedComponents: .date)
            }

            Section(header: Text("Exercise")) {
                ForEach($workout.exercises) { $exercise in
                    NavigationLink {
                        EditWorkoutExerciseView(workoutExercise: exercise)
                    } label: {
                        Text(exercise.template.name)
                    }
                }
            }
        }
        .navigationTitle("Workout")
    }
}
