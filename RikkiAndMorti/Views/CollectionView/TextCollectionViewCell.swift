//
//  TextCollectionViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setText(text: String) {
        if let label {
            label.text = text
        }
    }
}
