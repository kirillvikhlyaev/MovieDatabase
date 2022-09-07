//
//  SettingsTableViewCell.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 07.09.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    //MARK: - PomadoroViewController
    ///Фоновой цвет позади иконки.
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    ///Иконка-картинка в ячейке.
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 6
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    ///Текстовое описание настройки
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        self.tintColor = .white
        self.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 0.7986687667)
//        UIColor.init(_colorLiteralRed: 0.09, green: 0.09, blue: 0.13, alpha: 0.7)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        //        iconImageView.center = iconContainer.center
        
        label.frame = CGRect(
            x: 25 + iconContainer.frame.size.width,
            y: 0,
            width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
            height: contentView.frame.size.height
        )
    }
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        iconContainer.backgroundColor = nil
        label.text = nil
        iconImageView.image = nil
    }
    //MARK: - Configure
    public func configure(with model: SettingsOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconImageView.backgroundColor = model.iconBackgroundColor
    }
    
    
    
}
