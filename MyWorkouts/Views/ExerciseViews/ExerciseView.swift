import SwiftUI
import SwiftData

struct ExerciseView: View {
    @State private var isShowAddExerciseView: Bool = false
    @State private var isShowEditView: Bool = false
    
    @Environment(\.modelContext) private var context
    
    @StateObject private var viewModel: ExerciseViewModel
    
    init(context: ModelContext) {
        _viewModel = StateObject(wrappedValue: ExerciseViewModel(context: context))
    }

    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.exercises, id: \.persistentModelID) { exercise in
                        ExerciseRowView(title: exercise.title, description: exercise.descr, emoji: exercise.emoji)
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
                    Button(action: {
                        isShowAddExerciseView = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .background(Color(.systemGroupedBackground))
            .sheet(isPresented: $isShowAddExerciseView) {
                let newVM = NewExerciseViewModel(
                    context: viewModel.context,
                    onDone: {
                        viewModel.fetchExercises()
                    }
                )
                NewExerciseView(viewModel: newVM)
                    .presentationDetents([.medium])
            }

            .navigationDestination(isPresented: $isShowEditView) {
                let editVM = EditExerciseListViewModel(
                    context: viewModel.context,
                    onDone: {
                        viewModel.fetchExercises()
                    }
                )
                EditExerciseListView(viewModel: editVM)
            }
        }
    }

}

