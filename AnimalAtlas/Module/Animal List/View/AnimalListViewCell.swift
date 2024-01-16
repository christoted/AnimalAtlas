//
//  AnimalListViewCell.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import UIKit
import SnapKit

class AnimalListViewCell: UITableViewCell {
    
    // MARK: UI Components
    
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.dropShadow()
        view.backgroundColor = .white
        return view
    }()
    
    private var animalName: UILabel = {
        let label = UILabel()
        label.font = .heading1
        label.text = "Gajah"
        label.textColor = AnimalAtlasColor.textSecondy.color
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        self.contentView.addSubview(container)
        self.container.addSubview(animalName)
        
        container.snp.makeConstraints { make in
            make.left.top.equalTo(8)
            make.right.bottom.equalTo(-8)
        }
        
        animalName.snp.makeConstraints { make in
            make.center.equalTo(container)
        }
    }
    
    // Set Data
    func setAnimalListData(name: String?) {
        animalName.text = name ?? ""
    }
}
