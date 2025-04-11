//
//  ViewController.swift
//  Game of Thrones Project
//
//  Created by Andy Heredia on 5/4/25.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "Search your character"
        controller.searchBar.searchBarStyle = .minimal
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()
    
    
    private let charactersTableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifer)
        return tableview
    }()
    
    private var viewModel: HomeViewModel
    var suscriptions = Set<AnyCancellable>()
    
    init(viewwModel: HomeViewModel) {
        self.viewModel = viewwModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Game of Thrones"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(charactersTableView)
        
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        
        
        updateUI()
        // Colocamos el searchBar
        navigationItem.searchController = searchController
        // Le da color al cancel del searchbar
        navigationController?.navigationBar.tintColor = .black
        
        searchController.searchResultsUpdater = self
    }
    
    
    func updateUI() {
        self.viewModel.$filteredCharacters
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.charactersTableView.reloadData()
            }
            .store(in: &suscriptions)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        charactersTableView.frame = view.bounds
    }


}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifer, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
      
        
        let character = viewModel.filteredCharacters[indexPath.row]
       
        cell.titleCharacter.text = "Name: \(character.firstName)"
        cell.lastNameText.text = "Last Name: \(character.lastName)"
        cell.accessoryType = .disclosureIndicator
        
        guard let image = URL(string: character.imageUrl) else {return UITableViewCell()}
        
        cell.posterUIImageView.loadImageRemote(url: image)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Characters"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let character = self.viewModel.filteredCharacters[indexPath.row]
        
        let vc = DetailViewController()
        vc.configure(with: character)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Aquí asignamos al searchText del viewModel lo que vamos escribir en el searchBar
        viewModel.searchText = searchController.searchBar.text ?? ""
    }
    
    
}
