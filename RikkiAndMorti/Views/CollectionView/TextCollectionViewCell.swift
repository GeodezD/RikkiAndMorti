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
    
    func fetchData(_ url: String) {
         NetworkManager().fetchPage(str: url) { data in
            if let decodeData: ResultsEpisodes = NetworkManager().decodeData(data, into: ResultsEpisodes.self) {
                DispatchQueue.main.async {
                    self.label.text? = "Episode: \(decodeData.episode)\n"
                    self.label.text? += "Name: \(decodeData.name)\n"
                    self.label.text? += "Aired: \(decodeData.airDate)"
                }
            }
        }
    }
}
