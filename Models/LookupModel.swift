//
//  LookupModel.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 13/03/2022.
//

import Foundation

// MARK: - SystemLookup
struct LookupModel: Codable {
    let id: String?
    let array: [LookupArrayModel]?
}

// MARK: - Array
struct LookupArrayModel: Codable {
    let key, name: String?
}
