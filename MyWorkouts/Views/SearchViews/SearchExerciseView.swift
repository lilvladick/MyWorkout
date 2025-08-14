import SwiftUI
import SwiftData

struct SearchExerciseView: View {
    @Query private var allTemplates: [Exercise]
    @State var searchText: String = ""
    
    var filteredTemplates: [Exercise] {
        if searchText.isEmpty {
            return allTemplates
        } else {
            return allTemplates.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredTemplates) { template in
                Text(template.title)
            }
            .navigationTitle("Search Exercise")
            .searchable(text: $searchText, prompt: "Exercise search")
        }
    }
}

#Preview {
    SearchExerciseView()
}
