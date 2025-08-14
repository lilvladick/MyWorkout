import SwiftData
import SwiftUI

struct ExerciseListView: View {
    @Query var allExercises: [WorkoutExercise]
    @State private var selectedExercise: WorkoutExercise?
    
    var body: some View {
        List {
            ForEach(allExercises) { exercise in
                Button {
                    selectedExercise = exercise
                } label: {
                    Text(exercise.template.title)
                }
            }
        }
        .navigationTitle("Exercise Stats")
        .sheet(item: $selectedExercise) { exercise in
            ExerciseStatsView(exercise: exercise)
        }
    }
}
