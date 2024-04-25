//
//  HealthKitIntegrationApp.swift
//  Team-7-HMS
//
//  Created by Meghs on 25/04/24.
//

import SwiftUI
import HealthKit

class HealthKitManager: NSObject, ObservableObject {
    
    private let healthStore: HKHealthStore
    
    @Published var heartRate: Double = 0
    @Published var isWatchConnected = false
    
    @Published var bp_s : Double = 0
    
    @Published var bp_d : Double = 0
    
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

    func fetchBloodPressureData() {
        guard let bloodPressureType = HKObjectType.correlationType(forIdentifier: .bloodPressure) else {
            print("Blood pressure type not available in HealthKit")
            return
        }
        
        let query = HKSampleQuery(sampleType: bloodPressureType,
                                  predicate: nil,
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                print("Error fetching blood pressure samples: \(error.localizedDescription)")
                return
            }
            
            guard let samples = samples as? [HKCorrelation], !samples.isEmpty else {
                print("No blood pressure samples available")
                return
            }
            
            for sample in samples {
                if let systolic = sample.objects(for: HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!).first as? HKQuantitySample,
                   let diastolic = sample.objects(for: HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!).first as? HKQuantitySample {
                    // Access systolic and diastolic values here
                    let systolicValue = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                    let diastolicValue = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                    print("Systolic: \(systolicValue), Diastolic: \(diastolicValue)")
                    
                    
                    
                    self.bp_d = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                    self.bp_s = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                }
            }
        }
        
        HKHealthStore().execute(query)
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
