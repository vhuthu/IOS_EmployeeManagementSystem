//
//  Model.swift
//  APIProject
//
//  Created by DA MAC M1 162 on 2023/05/24.
//

import Foundation



struct ToDo: Codable {
    let email, department: String
    let employeeID: Int
    let firstname, contact, lastname: String

    enum CodingKeys: String, CodingKey {
        case email, department
        case employeeID = "employeeId"
        case firstname, contact, lastname
    }
}
