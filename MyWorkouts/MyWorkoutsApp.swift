//
//  MyWorkoutsApp.swift
//  MyWorkouts
//
//  Created by Владислав Кириллов on 28.07.2025.
//

import SwiftUI
import SwiftData

@main
struct MyWorkoutsApp: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Exercise.self,
            ExerciseSet.self,
            Workout.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(sharedModelContainer)
    }
}
