//
//  ValidationField.swift
//  DynamicFormBuilderTests
//
//  Created by Homam Abusaif on 14/03/2022.
//

import XCTest
@testable import DynamicFormBuilder

class ValidationField: XCTestCase {
    
    var viewModel: FormFieldVM!
//    var viewController: FormFieldVC!
    
    override func setUpWithError() throws {
        viewModel = FormFieldVM(fieldsModels: [FieldModel]())
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        viewController = storyboard.instantiateViewController(
//                identifier: String(describing: FormFieldVC.self))
//        viewController.loadViewIfNeeded()
//
//        viewController.viewModel = viewModel
        testAllFieldAreField()
    }

    override func tearDown(){
        viewModel = nil
//        viewController = nil
        super.tearDown()
    }
    
    func testAllFieldAreField(){
        XCTAssert(
            viewModel.allFieldsAreValid(rray: [
                FieldModel(name: "First Name",
                           label: "First Name",
                           type: .string,
                           lockups:([LookupArrayModel(key: "test", name: "test")]),
                           fieldRequired: false,
                           stringUserInput: ""),
                FieldModel(name: "c",
                           label: "c",
                           type: .selection,
                           lockups:([LookupArrayModel(key: "test", name: "test")]),
                           fieldRequired: true,
                           stringUserInput: nil,
                           lookupUserInput: LookupArrayModel(key: "test", name: "test")),
                FieldModel(name: "Email",
                           label: "Select ....",
                           type: .selection,
                           lockups:([LookupArrayModel(key: "test", name: "test")]),
                           fieldRequired: false,
                           stringUserInput: ""),
                FieldModel(name: "BOD",
                           label: "BOD",
                           type: .date,
                           lockups: nil,
                           fieldRequired: false,
                           stringUserInput: nil,
                           dateUserInput: nil),
                FieldModel(name: "Gender",
                           label: "Gender",
                           type: .date,
                           lockups:nil,
                           fieldRequired: false,
                           stringUserInput: ""),
                FieldModel(name: "Camera",
                           label: "Camera",
                           type: .attachement,
                           lockups: nil,
                           fieldRequired: false,
                           stringUserInput: ""),
                FieldModel(name: "Gallery",
                           label: "Gallery",
                           type: .date,
                           lockups: nil,
                           fieldRequired: false,
                           stringUserInput: "")
        ]), "Test With Error")
    }
    
//    func testOutletsShouldBeConnected() {
//        XCTAssertNotNil(viewController.submitButton, "submitButton")
//        XCTAssertNotNil(viewController.tableView, "tableView")
//    }
}
