//
//  AnimalListView.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit
import SnapKit
import RxSwift

class AnimalListView: UIView {
    
    // MARK: UI Components
    
    private lazy var animalListTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var viewModel: AnimalListViewModel?
    private let disposeBag = DisposeBag()
    var onCellTapped: ((String) -> Void)?
    
    // MARK: Init
    
    init(viewModel: AnimalListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        self.addSubview(animalListTableView)
        animalListTableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        animalListTableView.delegate = self
        animalListTableView.dataSource = self
        animalListTableView.register(AnimalListViewCell.self, forCellReuseIdentifier: AnimalListViewCell.className())
    }
}

extension AnimalListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.provideAnimalList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListViewCell.className(), for: indexPath) as? AnimalListViewCell else { return UITableViewCell() }
        let data = viewModel?.provideAnimalList()[indexPath.row]
        cell.selectionStyle = .none
        cell.setAnimalListData(name: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animalName = viewModel?.provideAnimalList()[indexPath.row]
        onCellTapped?(animalName ?? "")
    }
}
