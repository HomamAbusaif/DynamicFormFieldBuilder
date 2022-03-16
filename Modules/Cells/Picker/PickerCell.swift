//
//  PickerCell.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 28/02/2022.
//

import Foundation
import UIKit
import RxSwift


class PickerCell: UITableViewCell {
    
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var requiredLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerImage: UIImageView!

    var pickerView = UIPickerView()
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        pickerView = UIPickerView()
        pickerView.reloadAllComponents()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func setupPicker(indexPath: IndexPath, tableView: UITableView,element: FieldModel) -> PickerCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerCell
        cell.titleLabel.text = element.label
        cell.requiredLabel.isHidden = !(element.fieldRequired ?? false)
        cell.pickerTextField.text = element.lookupUserInput?.name ?? ""
        cell.pickerTextField.inputView = cell.pickerView
        cell.selectionStyle = .none
        cell .setupTheme()
        return cell
    }
    
    func setupTheme(){
        
        let theme  = Theme.shared.theme
        pickerTextField.textColor = theme?.textColor
        titleLabel.textColor = theme?.textColor
        requiredLabel.textColor = theme?.requiredColor
        pickerImage.tintColor = theme?.primaryColor
    }
}
