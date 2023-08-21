//
//  SettingViewController + extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.08.2023.
//

import UIKit

extension SettingViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        viewColorBackground.backgroundColor = viewController.selectedColor
        }
}
