//
//  TextFieldCell.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 24/02/2022.
//

import Foundation
import UIKit
import RxSwift

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textFied: UITextField!
    @IBOutlet var requiredLabel: UILabel!
    
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
    
    static func setupText(indexPath: IndexPath, tableView: UITableView,element: FieldModel) -> TextFieldCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
        cell.titleLabel.text = element.label
        cell.requiredLabel.isHidden = !(element.fieldRequired ?? false)
        cell.textFied.text = element.stringUserInput ?? ""
        cell.selectionStyle = .none
        cell.setupTheme()
        return cell
    }
    
    func setupTheme(){
        
        let theme  = Theme.shared.theme
        textFied.textColor = theme?.textColor
        titleLabel.textColor = theme?.textColor
        requiredLabel.textColor = theme?.requiredColor
    }
}
