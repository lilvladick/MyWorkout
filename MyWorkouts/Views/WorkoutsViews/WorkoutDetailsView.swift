import SwiftUI
import SwiftData

struct WorkoutDetailsView: View {
    @Bindable var workout: Workout
    @State private var heartRatePoints: [HeartRatePoint] = []

    var body: some View {
        Form {
            Section(header: Text("Info")) {
                TextField("Title", text: $workout.title)
                DatePicker("Date", selection: $workout.date, displayedComponents: .date)
                DatePicker("Start Time", selection: $workout.startTime, displayedComponents: [.hourAndMinute])
                DatePicker("End Time", selection: $workout.endTime, displayedComponents: [.hourAndMinute])
            }

            Section(header: Text("Exercise")) {
                ForEach($workout.exercises) { $exercise in
                    NavigationLink {
                        EditWorkoutExerciseView(workoutExercise: exercise)
                    } label: {
                        Text(exercise.template.title)
                    }
                }
            }
        }
        .navigationTitle("Workout")
    }
}
