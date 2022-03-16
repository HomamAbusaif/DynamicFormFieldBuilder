//
//  DelegateProxy.swift
//  DynamicFormBuilder
//
//  Created by Homam Abusaif on 07/03/2022.
//

import RxSwift
import RxCocoa
import UIKit

open class RxImagePickerDelegateProxy
    : RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {

    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }

}
