//
//  AnimalListView.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit
import SnapKit

class AnimalListView: UIView {
    
    // MARK: UI Components
    
    private lazy var animalListTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimalListViewCell.className(), for: indexPath) as? AnimalListViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
