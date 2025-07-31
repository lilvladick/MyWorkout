import SwiftUI
import Charts

struct ExerciseStatsView: View {
    var exercise: WorkoutExercise

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Weight over time")
                        .font(.headline)

                    Chart {
                        if exercise.sets.count >= 2 {
                            ForEach(Array(exercise.sets.enumerated()), id: \.offset) { index, set in
                                LineMark(
                                    x: .value("Set", index),
                                    y: .value("Weight", set.weight)
                                )
                            }
                        } else if let set = exercise.sets.first {
                            PointMark(
                                x: .value("Set", 0),
                                y: .value("Weight", set.weight)
                            )
                        }
                    }
                    .frame(height: 200)

                    Text("Reps over time")
                        .font(.headline)

                    Chart {
                        if exercise.sets.count >= 2 {
                            ForEach(Array(exercise.sets.enumerated()), id: \.offset) { index, set in
                                LineMark(
                                    x: .value("Set", index),
                                    y: .value("Reps", set.reps)
                                )
                            }
                        } else if let set = exercise.sets.first {
                            PointMark(
                                x: .value("Set", 0),
                                y: .value("Reps", set.reps)
                            )
                        }
                    }
                    .frame(height: 200)
                }
                .padding()
            }
            .navigationTitle(exercise.template.name)
            .presentationDetents([.large])
        }
    }
}
