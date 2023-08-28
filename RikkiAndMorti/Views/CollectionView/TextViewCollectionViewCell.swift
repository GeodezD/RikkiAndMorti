//
//  TextViewCollectionViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 21.08.2023.
//

import UIKit

class TextViewCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fetchData(_ url: String) {
         NetworkManager().fetchPage(str: url) { data in
            if let decodeData: ResultsEpisodes = NetworkManager().decodeData(data, into: ResultsEpisodes.self) {
                DispatchQueue.main.async {
                    self.textView.text = "Episode: \(decodeData.episode)\n"
                    self.textView.text += "Name: \(decodeData.name)\n"
                    self.textView.text += "Aired: \(decodeData.airDate)"
                }
            }
        }
    }
}
