//
//  User.swift
//  CarManager
//
//  Created by Kirill Kubarskiy on 17.04.23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let login: String
    let role: String
}
