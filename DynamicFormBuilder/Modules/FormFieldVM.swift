//
//  FormFieldVM.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 28/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class FormFieldVM{
    
    var loading: BehaviorSubject<Bool>
    var isLoading: Bool
    var errorMessage: PublishSubject<String>
    var isFinishFormFilling: PublishSubject<Bool>
    var fieldsModelsObs: BehaviorSubject<[FieldModel]>
    let retryAction = PublishSubject<Void>()
    
    var fieldsArray = [FieldModel]()
    var textChangedObs: PublishSubject<(String, FieldModel)>
    var selectedImageObs: PublishSubject<UIImage?>
    var selectedLockupModel: PublishSubject<(LookupArrayModel?, Int)>
    var selectedDate: PublishSubject<(Date, Int)>
    var selectedAttachement: PublishSubject<(UIImage?, Int)>
    var submitButtonTapped: PublishSubject<Void>
    var userRegistered: PublishSubject<Bool>
    
    let disposeBag = DisposeBag()
    
    init(fieldsModels: [FieldModel]){
        
        var fieldsModelsCopy = fieldsModels
        let attachementFields = [FieldModel]()
        
        fieldsModelsCopy.append(contentsOf: attachementFields)
        fieldsModelsCopy = fieldsModelsCopy.filter {$0.type != nil}
        
        loading = BehaviorSubject(value: false)
        isLoading = false
        errorMessage = PublishSubject()
        isFinishFormFilling = PublishSubject()
        
        fieldsModelsObs = BehaviorSubject(value: fieldsModelsCopy)
        textChangedObs = PublishSubject()
        selectedImageObs = PublishSubject()
        selectedLockupModel = PublishSubject()
        selectedDate = PublishSubject()
        selectedAttachement = PublishSubject()
        submitButtonTapped = PublishSubject()
        userRegistered = PublishSubject()
        
        fieldsModelsObs
            .subscribe(
                onNext: { [weak self] fieldsArray in
                    guard let self = self else { return }
                    self.fieldsArray = fieldsArray
                })
            .disposed(by: disposeBag)
        
        textChangedObs
            .subscribe(
                onNext: { obs in
                    obs.1.stringUserInput = obs.0
                    
                })
            .disposed(by: disposeBag)
        
        selectedLockupModel
            .subscribe(
                onNext: { [weak self] selectedLockup in
                    guard let self = self else { return }
                    let item = self.fieldsArray[selectedLockup.1]
                    item.lookupUserInput = selectedLockup.0
                })
            .disposed(by: disposeBag)
        
        selectedDate
            .subscribe(
                onNext: { [weak self] date in
                    guard let self = self else { return }
                    let item = self.fieldsArray[date.1]
                    item.dateUserInput = date.0
                })
            .disposed(by: disposeBag)
        
        selectedAttachement
            .subscribe(
                onNext: { [weak self] image in
                    guard let self = self else { return }
                    let item = self.fieldsArray[image.1]
                    item.imageUserInput = image.0
                })
            .disposed(by: disposeBag)
        
        submitButtonTapped
            .subscribe(
                onNext:{ [weak self] _ in
                    guard let self = self else { return }
                    
                    if self.allFieldsAreValid(rray: self.fieldsArray) {
                        self.isFinishFormFilling.onNext(true)
                        
                    }else{
                        self.errorMessage.onNext("Please fill all required fields")
                    }
                })
            .disposed(by: disposeBag)
    }
    
    func allFieldsAreValid(rray: [FieldModel]) -> Bool {
        var allFieldValid = false
        
        for field in rray {
            if field.fieldRequired ?? false {
                if !isValidField(field: field){
                    return false
                }
                allFieldValid = true
            }
        }
        
        return allFieldValid
    }
    
    func isValidField(field: FieldModel) -> Bool {
        switch field.type ?? .none{
            
        case .string:
            return isValidString(text: field.stringUserInput)
        case .selection:
            return isValidLockup(lockup: field.lookupUserInput)
        case .date:
            return isValidDate(date: field.dateUserInput)
        case .attachement:
            return isValidAttachment(attachment: field.imageUserInput)
        case .none:
            break
        }
        
        return false
        
    }
    
    func isValidString(text: String?) -> Bool {
        if text?.count != 0 && text != nil{
            return true
        }
        
        return false
    }
    
    func isValidLockup(lockup: LookupArrayModel?) -> Bool {
        if lockup != nil && lockup?.key != nil {
            return true
        }
        
        return false
    }
    
    func isValidDate(date: Date?) -> Bool {
        if date != nil {
            return true
        }
        
        return false
    }
    
    func
    
    isValidAttachment(attachment: UIImage?) -> Bool {
        if attachment != nil{
            return true
        }
        
        return false
    }
}
