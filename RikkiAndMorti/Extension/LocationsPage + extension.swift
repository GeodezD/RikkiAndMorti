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
        print("\(indexPath.item)")
        let viewCell = Episode()
        viewCell.indexPathCelltable = indexPath.item
        
        let activityIndikator = ActivityIndikator()
        activityIndikator.takeFrame(frame: view.frame)
        view.addSubview(activityIndikator.setupView())
        activityIndikator.activate(.on)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewCell, animated: true)
            activityIndikator.activate(.off)
        }
    }
}

/*
 LocationsModel(
    info: RikkiAndMorti.InfoLocations(count: 126,
                                    pages: 7,
                                    next: Optional("https://rickandmortyapi.com/api/location/?page=2"),
                                    prev: nil),
 
    results: [RikkiAndMorti.ResultsLocations(id: 1,
                                            name: "Earth (C-137)",
                                            type: "Planet",
                                            dimension: "Dimension C-137",
                                            residents: ["https://rickandmortyapi.com/api/character/38", "https://rickandmortyapi.com/api/character/45", "https://rickandmortyapi.com/api/character/71", "https://rickandmortyapi.com/api/character/82", "https://rickandmortyapi.com/api/character/83", "https://rickandmortyapi.com/api/character/92", "https://rickandmortyapi.com/api/character/112", "https://rickandmortyapi.com/api/character/114", "https://rickandmortyapi.com/api/character/116", "https://rickandmortyapi.com/api/character/117", "https://rickandmortyapi.com/api/character/120", "https://rickandmortyapi.com/api/character/127", "https://rickandmortyapi.com/api/character/155", "https://rickandmortyapi.com/api/character/169", "https://rickandmortyapi.com/api/character/175", "https://rickandmortyapi.com/api/character/179", "https://rickandmortyapi.com/api/character/186", "https://rickandmortyapi.com/api/character/201", "https://rickandmortyapi.com/api/character/216", "https://rickandmortyapi.com/api/character/239", "https://rickandmortyapi.com/api/character/271", "https://rickandmortyapi.com/api/character/302", "https://rickandmortyapi.com/api/character/303", "https://rickandmortyapi.com/api/character/338", "https://rickandmortyapi.com/api/character/343", "https://rickandmortyapi.com/api/character/356", "https://rickandmortyapi.com/api/character/394"],
                                            url: "https://rickandmortyapi.com/api/location/1",
                                            created: "2017-11-10T12:42:04.162Z"),
                                            .............
                                            ])
 */
