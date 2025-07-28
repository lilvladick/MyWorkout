import SwiftData
import SwiftUI

struct EditWorkoutExerciseView: View {
    @Bindable var workoutExercise: WorkoutExercise
    @State private var weight: String = ""
    @State private var reps: String = ""

    var body: some View {
        Form {
            Section(header: Text("Add exercise set")) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                TextField("Repeats", text: $reps)
                    .keyboardType(.numberPad)
                Button("Add") {
                    if let w = Double(weight), let r = Int(reps) {
                        workoutExercise.sets.append(ExerciseSet(weight: w, reps: r))
                        weight = ""
                        reps = ""
                    }
                }
            }

            Section(header: Text("Sets")) {
                ForEach(workoutExercise.sets) { set in
                    Text("Weight: \(set.weight), Repeats: \(set.reps)")
                }
            }
        }
        .navigationTitle(workoutExercise.template.name)
    }
}
