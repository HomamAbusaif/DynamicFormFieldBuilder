//
//  InitialVC.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 13/03/2022.
//

import UIKit

class InitialVC: UIViewController {
    
    var formVC: FormFieldVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        formVC = storyboard.instantiateViewController(withIdentifier: "FormFieldVC") as! FormFieldVC
        
        let formVM = FormFieldVM(fieldsModels: [FieldModel(name: "First Name",
                       label: "First Name",
                       type: .string,
                       lockups:([LookupArrayModel(key: "test", name: "test")]),
                       fieldRequired: true,
                       stringUserInput: "Jone"),
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
    ])
        
        formVC.viewModel = formVM
        formVC.delegate = self
        
        self.present(formVC, animated: true, completion: nil)
    }
}

extension InitialVC: FormFieldVCDelegate{
    func didFinishFormFiling(rootViewController: UIViewController, fields: [FieldModel]) {
        formVC.dismiss(animated: true) {
            print("didFinishFormFiling")
        }
    }
    
    func showAlert(rootViewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(ok)
        rootViewController.present(alert, animated: true)
    }
}
