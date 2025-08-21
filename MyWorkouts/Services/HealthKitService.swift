import HealthKit
import Foundation

final class HealthKitService {
    static let shared = HealthKitService()
    private let healthStore = HKHealthStore()

    private var heartRateType: HKQuantityType {
        HKQuantityType.quantityType(forIdentifier: .heartRate)!
    }

    func requestAuthorization() async throws -> Bool {
        try await healthStore.requestAuthorization(toShare: [], read: [heartRateType])
        return healthStore.authorizationStatus(for: heartRateType) == .sharingAuthorized
    }

    func fetchHeartRatePoints(startDate: Date, endDate: Date) async throws -> [HeartRatePoint] {
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: [.strictStartDate, .strictEndDate]
        )

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: heartRateType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)]
            ) { _, samples, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let hrSamples = samples as? [HKQuantitySample] else {
                    continuation.resume(returning: [])
                    return
                }

                let points = hrSamples.map {
                    HeartRatePoint(
                        date: $0.startDate,
                        bpm: $0.quantity.doubleValue(for: HKUnit(from: "count/min"))
                    )
                }

                continuation.resume(returning: points)
            }
            healthStore.execute(query)
        }
    }
}
