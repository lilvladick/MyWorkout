import SwiftData
import SwiftUI

struct NewWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = WorkoutNewViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Workout Information")) {
                    TextField("Title", text: $viewModel.title)
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
                
                Section(header: Text("Workout Time")) {
                    DatePicker("Start Time", selection: $viewModel.startTime, displayedComponents: [.hourAndMinute])
                    DatePicker("End Time", selection: $viewModel.endTime, displayedComponents: [.hourAndMinute])
                }

                Section(header: Text("Exercises")) {
                    if viewModel.exercises.isEmpty {
                        Text("No exercises added yet")
                            .foregroundStyle(.secondary)
                    }
                    
                    ForEach(viewModel.exercises) { workoutExercise in
                        NavigationLink {
                            EditWorkoutExerciseView(workoutExercise: workoutExercise)
                        } label: {
                            Text(workoutExercise.template.title)
                        }
                    }
                    .onDelete(perform: viewModel.deleteExercise)
                    
                    NavigationLink("Add Exercise") {
                        AddExerciseTemplateView(
                            viewModel: {
                                let addVM = AddExerciseTemplateViewModel(
                                    context: context,
                                    selected: viewModel.exercises.map { $0.template }
                                )
                                addVM.onDone = { newExercises in
                                    viewModel.exercises = newExercises.map { WorkoutExercise(template: $0) }
                                }
                                return addVM
                            }()
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Clear") {
                        viewModel.clearForm()
                    }
                    .disabled(!viewModel.canClear)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        do {
                            try viewModel.saveWorkout()
                            dismiss()
                        } catch {
                            print("Failed to save workout:", error.localizedDescription)
                        }
                    }
                    .disabled(!viewModel.canSave)
                }
            }
        }
        .onAppear {
            if viewModel.context == nil {
                viewModel.setContext(context)
            }
        }
    }
}
