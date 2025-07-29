import SwiftUI
import SwiftData

struct WorkoutsView: View {
    @Query private var workouts: [Workout]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    NavigationLink {
                        WorkoutDetailsView(workout: workout)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                                .font(.headline)
                            Text(workout.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let workout = workouts[index]
                        context.delete(workout)
                    }
                    try? context.save()
                }
            }
            .navigationTitle("All Workouts")
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
        }
    }
}
