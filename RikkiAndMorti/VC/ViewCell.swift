//
//  ViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 10.07.2023.
//

import UIKit

class ViewCell: UIViewController {
    private var data: Model?
    var indexPathCell: Int?
    private var viewImage = UIImageView()
    private var image: UIImage? {
        didSet {
            viewImage.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        guard  let  indexPathCell = indexPathCell else { return }
        let data = UserDefaults.standard.data(forKey: "Data")
        guard let data = data else { return }
        do {
            let decoderJSON = try JSONDecoder().decode(Model.self, from: data)
            giveImage(with: decoderJSON.results[indexPathCell].image)
            print("Data")
        } catch {
            print("error: ", error)
        }
        print(indexPathCell)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraint()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(viewImage)
        
    }
    
    private func setupConstraint() {
        viewImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            viewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            viewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            viewImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func giveImage(with picture: String) {
        guard let url = URL(string: picture) else { fatalError( "Error" ) }
        GetImage().downloadImage(url: url) { image in
            self.image = image
            print("YES")
        }
    }
    

}

