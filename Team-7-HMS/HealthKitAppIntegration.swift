//
//  HealthKitIntegrationApp.swift
//  Team-7-HMS
//
//  Created by Meghs on 25/04/24.
//

import SwiftUI
import HealthKit

class HealthKitManager: NSObject, ObservableObject {
    
    let healthStore: HKHealthStore
    
    @Published var heartRate: Double = 0
    @Published var isWatchConnected = false
    
    private var heartRateQuery: HKQuery?
    
    override init() {
        self.healthStore = HKHealthStore()
        super.init()
        
        checkWatchConnection()
        startObservingHeartRate()
    }
    
    func checkWatchConnection() {
        let workoutType = HKObjectType.workoutType()
        let authorizationStatus = healthStore.authorizationStatus(for: workoutType)
        if authorizationStatus == .sharingAuthorized {
            isWatchConnected = true
        } else {
            isWatchConnected = false
        }
    }
    
    func startObservingHeartRate() {
        let quantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        let observerQuery = HKObserverQuery(sampleType: quantityType, predicate: nil) { [weak self] query, completionHandler, error in
            guard let self = self else { return }
            if let error = error {
                print("Error in observer query: \(error.localizedDescription)")
                return
            }
            
            self.readLatestHeartRate()
            completionHandler()
        }
        
        healthStore.execute(observerQuery)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let sampleQuery = HKSampleQuery(sampleType: quantityType,
                                        predicate: nil,
                                        limit: 1,
                                        sortDescriptors: [sortDescriptor]) { [weak self] query, results, error in
            guard let self = self else { return }
            guard let sample = results?.first as? HKQuantitySample else {
                print("Error fetching latest heart rate sample: \(error?.localizedDescription ?? "")")
                return
            }
            
            let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            DispatchQueue.main.async {
                self.heartRate = heartRate
            }
        }
        
        healthStore.execute(sampleQuery)
        heartRateQuery = sampleQuery
    }

    func readLatestHeartRate() {
        let quantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let sampleQuery = HKSampleQuery(sampleType: quantityType,
                                        predicate: nil,
                                        limit: 1,
                                        sortDescriptors: [sortDescriptor]) { (query, results, error) in
            guard let samples = results as? [HKQuantitySample], let sample = samples.first else {
                print("Error fetching latest heart rate sample: \(error?.localizedDescription ?? "")")
                return
            }
            
            let heartRate = sample.quantity.doubleValue(for: HKUnit(from: "count/min"))
            self.heartRate = heartRate
            print("Latest heart rate: \(heartRate)")
        }
        
        healthStore.execute(sampleQuery)
    }
}
