//
//  FormFieldVC.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 24/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol FormFieldVCDelegate: NSObject {
    func showAlert(rootViewController: UIViewController, message: String)
    func didFinishFormFiling(rootViewController: UIViewController, fields: [FieldModel])
}

class FormFieldVC: UIViewController {
    
    @IBOutlet private(set) var tableView: UITableView!
    @IBOutlet private(set) var submitButton: UIButton!
    
    var viewModel: FormFieldVM!
    private let disposeBag = DisposeBag()
    var delegate: FormFieldVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        setupTheme()
    }
    
    func setupTableView(){
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "TextFieldNib", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        tableView.register(UINib(nibName: "PickerNib", bundle: nil), forCellReuseIdentifier: "PickerCell")
        tableView.register(UINib(nibName: "DatePickerNib", bundle: nil), forCellReuseIdentifier: "DatePickerCell")
        tableView.register(UINib(nibName: "FileNib", bundle: nil), forCellReuseIdentifier: "FileCell")
    }
    
    func setupBindings(){
        
        viewModel.isFinishFormFilling
            .subscribe(
                onNext:{ [weak self] isFinish in
                    guard let self = self else { return }
                    self.delegate?.didFinishFormFiling(rootViewController: self, fields: self.viewModel.fieldsArray)
                })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .subscribe(
                onNext:{ [weak self] message in
                    guard let self = self else { return }
                    self.delegate?.showAlert(rootViewController: self, message: message)
                    
                })
            .disposed(by: disposeBag)
        
        viewModel.fieldsModelsObs
            .asDriver(onErrorJustReturn: [FieldModel]())
            .drive(tableView.rx.items) {
                
                (tableView: UITableView, index: Int, element: FieldModel) in
                let indexPath = IndexPath(item: index, section: 0)
                let type = element.type
                
                switch type {
                case .string:
                    
                    let cell = TextFieldCell.setupText(indexPath: indexPath, tableView: tableView, element: element)
                    cell.textFied
                        .rx.textInput.text.orEmpty
                        .map{ ($0, element) }
                        .bind(to: self.viewModel.textChangedObs)
                        .disposed(by: cell.disposeBag)
                    
                    return cell
                    
                case .selection:
                    
                    let cell = PickerCell.setupPicker(indexPath: indexPath, tableView: tableView, element: element)
                    Observable.just(element.lockups ?? [LookupArrayModel]())
                        .asDriver(onErrorJustReturn: [LookupArrayModel]())
                        .drive(cell.pickerView.rx.itemTitles) { _, item in
                            return item.name ?? ""
                        }.disposed(by: cell.disposeBag)
                    
                    cell.pickerView.rx
                        .itemSelected
                        .asObservable()
                        .subscribe(
                            onNext:{ [weak self] selecteIndex in
                                guard let self = self else { return }
                                let selectedLockup = element.lockups?[selecteIndex.row]
                                cell.pickerTextField.text = selectedLockup?.name ?? ""
                                self.viewModel.selectedLockupModel.onNext((selectedLockup, index))
                            })
                        .disposed(by: cell.disposeBag)
                    
                    return cell
                    
                case .date:
                    
                    let cell = DatePickerCell.setupDate(indexPath: indexPath, tableView: tableView, element: element)
                    
                    let datePickerView  : UIDatePicker = UIDatePicker()
                    datePickerView.datePickerMode = UIDatePicker.Mode.date
                    if #available(iOS 14.0, *) {
                        datePickerView.preferredDatePickerStyle = UIDatePickerStyle.inline
                        
                    }
                    
                    datePickerView.autoresizingMask = .flexibleRightMargin
                    datePickerView.rx.value.changed.asObservable()
                        .subscribe({ [weak self] event in
                            guard let self = self else { return }
                            
                            if let date = event.element{
                                let theFormatter = DateFormatter()
                                theFormatter.dateStyle = .medium
                                let theString = theFormatter.string(from: date)
                                cell.datePickerTextField.text = theString
                                
                                self.viewModel.selectedDate.onNext((date, index))
                            }
                        })
                        .disposed(by: cell.disposeBag)
                    
                    cell.datePickerTextField.inputView = datePickerView
                    return cell
                    
                case .attachement:
                    let cell = FileCell.setupAttachment(indexPath: indexPath, tableView: tableView, element: element)
                    cell.importImageButton.rx.tap
                        .flatMapLatest { [weak self] _ in
                            return UIImagePickerController.rx.createWithParent(self) { picker in
                                picker.sourceType = .photoLibrary
                                picker.allowsEditing = false
                            }
                            .flatMap {
                                $0.rx.didFinishPickingMediaWithInfo
                            }
                            .take(1)
                        }
                        .map { info in
                            return info[.originalImage] as? UIImage
                        }
                        .map{ ($0,index) }
                        .bind(to: self.viewModel.selectedAttachement)
                        .disposed(by: cell.disposeBag)
                    
                    return cell
                    
                case .none:
                    return UITableViewCell()
                }
            }
            .disposed(by: self.disposeBag)
        
        submitButton.rx
            .tap
            .asDriver(onErrorJustReturn: ())
            .drive(viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
        
        viewModel.selectedAttachement
            .subscribe(
                onNext:{ _ in
                    self.tableView.reloadData()
                })
            .disposed(by: disposeBag)
    }
    
    func setupTheme(){
        let theme  = Theme.shared.theme
        
        submitButton.backgroundColor = theme?.primaryColor
        submitButton.setTitleColor(theme?.buttonTextColor, for: .normal)
    }
}
