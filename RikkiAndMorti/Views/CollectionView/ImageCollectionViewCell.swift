//
//  ImageCollectionViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
        func setImage(with picture: String) {
            print(picture)
            guard let url = URL(string: picture) else { fatalError( "Error" ) }
            GetImage().downloadImage(url: url) { image in
                if let downloadImage = image {
                    self.imageView.image = downloadImage
                }
            }
        }
    }
