//
//  FieldModel.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 28/02/2022.
//


import Foundation
import UIKit

// MARK: - Field
class FieldModel: Codable {
    var name, label: String?
    var type: FormFieldType?
    var fieldRequired: Bool?
    var lookupKey: String?
    var attachment: [FieldModel]?
    var stringUserInput: String? = ""
    var lockups: [LookupArrayModel]?
    var lookupUserInput: LookupArrayModel? = LookupArrayModel(key: nil, name: nil)
    var dateUserInput: Date? = Date()
    var imageUserInput: UIImage?

    init(name: String, label: String, type: FormFieldType, lockups: [LookupArrayModel]?, fieldRequired: Bool, stringUserInput: String?, lookupUserInput: LookupArrayModel? = nil, dateUserInput: Date? = nil){
        self.name = name
        self.label = label
        self.type = type
        self.lockups = lockups
        self.fieldRequired = fieldRequired
        self.stringUserInput = stringUserInput
        self.lookupUserInput = lookupUserInput
        self.dateUserInput = dateUserInput
    }
    
    enum CodingKeys: String, CodingKey {
        case name, label, type
        case fieldRequired = "required"
        case lockups
        case lookupKey = "lookup_key"
        case attachment
    }
}

enum FormFieldType: String, Codable {
    case date = "Date"
    case selection = "Selection"
    case string = "String"
    case attachement = "attachement"
}
