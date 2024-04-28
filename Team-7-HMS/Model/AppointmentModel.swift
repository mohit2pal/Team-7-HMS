//
//  AppointmentModel.swift
//  Team-7-HMS
//
//  Created by Meghs on 27/04/24.
//
import Foundation

struct AppointmentModel {
    var id = UUID()
    var date: Date
    var specialist: String
    var doctor: String
    var slot: String
}
