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
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.name) private var myExercises: [Exercise]
    
    var body: some View {
        NavigationStack{
            List{
                if filter == .my {
                    if myExercises.isEmpty {
                        Text("No exercises yet.").foregroundStyle(.secondary)
                    } else {
                        ForEach(myExercises, id: \.persistentModelID) { exercise in
                            ExerciseRow(title: exercise.name, description: exercise.descr)
                        }.onDelete(perform: deleteExercises)
                    }
                } else {
                    Text("Now it's not working...")
                }
            }
            .navigationTitle("Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $filter) {
                            ForEach(ExerciseFilter.allCases) { filterOption in
                                Text(filterOption.rawValue)
                                    .tag(filterOption)
                            }
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        isShowAddExerciseView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowAddExerciseView) {
                NewExerciseView().presentationDetents([.medium])
            }
        }
    }
    
    private func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            let toDelete = myExercises[index]
            context.delete(toDelete)
        }
        try? context.save()
    }
}

#Preview {
    ExerciseView()
}
