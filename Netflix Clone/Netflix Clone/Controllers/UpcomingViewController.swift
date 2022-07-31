//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Sahil Sahu on 18/06/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
        return table
    }()
    
    var titles: [Title] = [Title]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //view.backgroundColor =  .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        upcomingTable.allowsSelection = true
        view.addSubview(upcomingTable)
        
        fetchUpcomingMovies()
        
    }
    
    private func fetchUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] results in
            switch results {
            case .success(let res):
                
                DispatchQueue.main.async {
                    self?.titles = res
                    self?.upcomingTable.reloadData()
                }
            case .failure(let err):
                print(err)
            
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }

}

extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        
        DispatchQueue.main.async {
            cell.configure(with: self.titles[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        APICaller.shared.getMovie(with: titles[indexPath.row].original_title ?? titles[indexPath.row].original_name ?? "" ) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewModel(title: self?.titles[indexPath.row].original_title ?? self?.titles[indexPath.row].original_name ?? "Unknown", youtubeVideo: videoElement, titleOverview: self?.titles[indexPath.row].overview ?? ""))
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
