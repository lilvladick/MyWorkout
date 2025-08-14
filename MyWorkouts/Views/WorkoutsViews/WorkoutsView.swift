import SwiftUI
import SwiftData

struct WorkoutsView: View {
    @Query private var workouts: [Workout]
    @Environment(\.modelContext) private var context
    
    @State private var isShowAddWorkoutSheet: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(workouts, id: \.persistentModelID) { workout in
                        NavigationLink {
                            WorkoutDetailsView(workout: workout)
                        } label: {
                            WorkoutRowView(title: workout.title, date: workout.date)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("All Workouts")
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                   Button(action: {
                       isShowAddWorkoutSheet.toggle()
                   }, label: {
                       Image(systemName: "plus")
                   })
                }
            }
            .sheet(isPresented: $isShowAddWorkoutSheet) {
                NewWorkoutView()
                    .presentationDetents([.large])
            }
        }
    }
}
