import SwiftUI
import SwiftData

enum ExerciseFilter: String, CaseIterable, Identifiable {
    case my = "My Exercises"
    case all = "All Exercises"
    var id: String { rawValue }
}

struct ExerciseView: View {
    @State private var filter: ExerciseFilter = .my
    @State private var isShowAddExerciseView: Bool = false
    @State private var isShowEditView: Bool = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.name) private var myExercises: [Exercise]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 12) {
                    if filter == .my {
                        if myExercises.isEmpty {
                            Text("No exercises yet.").foregroundStyle(.secondary)
                        } else {
                            ForEach(myExercises, id: \.persistentModelID) { exercise in
                                ExerciseRow(title: exercise.name, description: exercise.descr, emoji: exercise.emoji)
                            }
                        }
                    } else {
                        Text("Now it's not working...")
                    }
                }
                .padding()
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                        isShowEditView = true
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Add Exercise", action: { isShowAddExerciseView = true })
                        Picker("Filter", selection: $filter) {
                            ForEach(ExerciseFilter.allCases) { filterOption in
                                Text(filterOption.rawValue).tag(filterOption)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .sheet(isPresented: $isShowAddExerciseView) {
                NewExerciseView().presentationDetents([.medium])
            }
            .navigationDestination(isPresented: $isShowEditView) {
                EditExerciseListView()
            }
        }
    }

}

#Preview {
    ExerciseView()
}
