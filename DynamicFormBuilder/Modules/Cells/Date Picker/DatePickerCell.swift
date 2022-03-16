//
//  DatePickerCell.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 06/03/2022.
//


import Foundation
import UIKit
import RxSwift

class DatePickerCell: UITableViewCell {
    
    @IBOutlet var datePickerTextField: UITextField!
    @IBOutlet var requiredLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePickerImage: UIImageView!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func setupDate(indexPath: IndexPath, tableView: UITableView,element: FieldModel) -> DatePickerCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! DatePickerCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let dateString = dateFormatter.string(from: element.dateUserInput ?? Date())
        cell.requiredLabel.isHidden = !(element.fieldRequired ?? false)
        cell.datePickerTextField.text = dateString
        cell.titleLabel.text = element.label
        cell .setupTheme()
        cell.selectionStyle = .none
        
        return cell
    }
    
    func setupTheme(){
        
        let theme  = Theme.shared.theme
        titleLabel.textColor = theme?.textColor
        datePickerTextField.textColor = theme?.textColor
        requiredLabel.textColor = theme?.requiredColor
        datePickerImage.tintColor = theme?.primaryColor

    }
}
