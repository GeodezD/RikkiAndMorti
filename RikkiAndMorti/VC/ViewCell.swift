//
//  ViewCell.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 10.07.2023.
//

import UIKit

class ViewCell: UIViewController {
    private let memory = Memory()

    var indexPathCell: Int?
    private var viewImage = UIImageView()
    private var image: UIImage? {
        didSet {
            viewImage.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
        setup()
//        guard  let  indexPathCell = indexPathCell else { return }
//        let data = UserDefaults.standard.data(forKey: "Data")
//        guard let data = data else { return }
//        do {
//            let decoderJSON = try JSONDecoder().decode(Model.self, from: data)
//            giveImage(with: decoderJSON.results[indexPathCell].image)
//            print("Data")
//        } catch {
//            print("error: ", error)
//        }
//        print(indexPathCell)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraint()
    }
    
    private func downloadImage() {
        print("Download image")
        
        guard let indexPathCell = indexPathCell else { return }
        let data = memory.exportFetchData().results[indexPathCell].image
//        guard let picture = ViewController().data?.results[indexPathCell].image else { fatalError("I'm don't have url") }
        DispatchQueue.main.async {
            self.giveImage(with: data)
        }
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
            viewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            viewImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    func giveImage(with picture: String) {
        print("I'm give image")
        guard let url = URL(string: picture) else { fatalError( "Error" ) }
        GetImage().downloadImage(url: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
            print("YES")
        }
    }
}

