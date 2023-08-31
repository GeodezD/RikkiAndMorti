//
//  LocationsPage + Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 17.08.2023.
//

import UIKit

extension LocationsPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { fatalError(" None data") }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath)
        guard let locationCell = cell as? EpisodeTableViewCell else { fatalError() }
        
        locationCell.setLabel(with: "\(data.results[indexPath.item].name)",
                             label: locationCell.labelEpisode,
                             font: 20,
                             name: "Name",
                             bold: true)
        
        locationCell.setLabel(with: "\(data.results[indexPath.item].type)",
                             label: locationCell.labelNameEpisode,
                             font: 18,
                             name: "Type",
                             bold: false)
        
        locationCell.setLabel(with: "\(data.results[indexPath.item].dimension)",
                             label: locationCell.labelAired,
                             font: 16,
                             name: "Dimension",
                             bold: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCell = CharactersInEpisode()
        viewCell.indexPathCelltable = indexPath.item
        startAcitivityIndikator()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewCell, animated: true)
            DispatchQueue.main.async {
                viewCell.navigationTitle(title: "Characters in location")
                self.stopAcitivityIndikator()
            }
        }
    }
}

