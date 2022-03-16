//
//  FileCell.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 06/03/2022.
//

import Foundation
import UIKit
import RxSwift

class FileCell: UITableViewCell {
    
    @IBOutlet weak var importImageButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
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
        static func setupAttachment(indexPath: IndexPath, tableView: UITableView,element: FieldModel) -> FileCell{
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as! FileCell
            cell.importImageButton.setTitle("Choose \(element.label ?? "")", for: .normal)
            cell.myImageView.image = element.imageUserInput ?? UIImage()
            cell.requiredLabel.isHidden = !(element.fieldRequired ?? false)
            cell.selectionStyle = .none
            cell .setupTheme()
            return cell
        }
    
    func setupTheme(){
        
        let theme  = Theme.shared.theme
        importImageButton.backgroundColor = theme?.primaryColor
        importImageButton.setTitleColor(theme?.buttonTextColor, for: .normal)
        requiredLabel.textColor = theme?.requiredColor
    }
}
