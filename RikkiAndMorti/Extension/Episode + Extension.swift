//
//  Episode + Extension.swift
//  RikkiAndMorti
//
//  Created by Дмитро Сегейда on 27.07.2023.
//

import UIKit

extension Episode: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data else { fatalError(" None data ") }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath)
        guard let episodeCell = cell as? EpisodeTableViewCell else { fatalError("EpisodeTableViewCell = NIL") }
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].episode)",
                             label: episodeCell.labelEpisode,
                                                  font: 20,
                             name: "Episode",
                             bold: true)
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].name)",
                             label: episodeCell.labelNameEpisode,
                             font: 18,
                             name: "Name",
                             bold: false)
        
        episodeCell.setLabel(with: "\(data.results[indexPath.item].airDate)",
                             label: episodeCell.labelAired,
                             font: 16,
                             name: "Aired",
                             bold: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        let viewCell = EpisodeViewCell()
        viewCell.indexPathCelltable = indexPath.item
        navigationController?.pushViewController(viewCell, animated: true)
    }
}
