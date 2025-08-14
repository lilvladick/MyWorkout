import SwiftUI
import SwiftData

struct ExerciseView: View {
    @State private var isShowAddExerciseView: Bool = false
    @State private var isShowEditView: Bool = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.title) private var myExercises: [Exercise]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(myExercises, id: \.persistentModelID) { exercise in
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
