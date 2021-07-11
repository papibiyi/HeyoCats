//
//  AllCatsViewController.swift
//  HeyoCats
//
//  Created by Mojisola Adebiyi on 07/07/2021.
//

import UIKit

class AllCatsViewController: GenericViewController<AllCatsView> {
    let viewModel: AllCatsViewModel
    
    init(viewModel: AllCatsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$cats.dropFirst().sink {[weak self] _ in
            DispatchQueue.main.async {
                self?.contentView.tableView.removeEmptyView()
                self?.contentView.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    private func setupTableView() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.setEmptyView(.loading(message: "Meown 🐈\nThe Cats are coming"))
    }
}

extension AllCatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.cats[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AllCatsTableViewCell.reuseId, for: indexPath) as? AllCatsTableViewCell
        cell?.configureCell(with: data)
        cell?.isFavourited(viewModel.isFavotite(row: indexPath.row))
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let url = viewModel.cats[indexPath.row].image?.url ?? ""
        let cell = cell as? AllCatsTableViewCell
        DispatchQueue.global(qos: .background).async {
            cell?.loadImageFrom(url: url)
        }
        
        cell?.didPressLike = {[weak self] in
            guard let isFavourite = self?.viewModel.saveCat(row: indexPath.row) else {return}
            (tableView.cellForRow(at: indexPath) as? AllCatsTableViewCell)?.isFavourited(isFavourite)
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewModel.cats.isEmpty ? nil : contentView.allCatsLabel
    }    
}
