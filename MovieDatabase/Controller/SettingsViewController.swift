//
//  SettingsViewController.swift
//  MovieDatabase
//
//  Created by Ilya Vasilev on 07.09.2022.
//

import UIKit

// MARK: - Settings View Controller
struct Section {
    let title: String
    let options: [SettingsOptionType]
}
enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn:  Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController {
    // MARK: - Let-var
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    var models = [Section]()
    // MARK: - Lifecycle
    
    @IBOutlet weak var userProfileVIew: UIView!
    @IBOutlet weak var settingsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCell()
        
        title = "Профиль"
        view.addSubview(settingsView)
        view.addSubview(userProfileVIew)
        settingsView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = settingsView.bounds
        tableView.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1294117647, alpha: 1)
        tableView.sectionIndexColor = .white
        tableView.tintColor = .white
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8470588235, green: 0.1215686275, blue: 0.2352941176, alpha: 1)

    }
    // MARK: - Methods
    
    func configureCell() {
        models.append(Section(title: "Язык", options: [
          
            .staticCell(model: SettingsOption(
                title: "Язык",
                icon: UIImage(systemName: "character"),
                iconBackgroundColor: .systemIndigo,
                handler: {
            
                })),
]))
            
            models.append(Section(title: "Настройки", options: [
                .switchCell(model: SettingsSwitchOption(
                    title: "Тёмная тема",
                    icon: UIImage(systemName:"moon.fill"),
                    iconBackgroundColor: .systemIndigo,
                    handler: {
                    
                },
                    isOn: false))
                        ]))
        
        models.append(Section(title: "Help & feedback", options: [
            .staticCell(model: SettingsOption(
                title: "Email us",
                icon: UIImage(systemName: "mail"),
                iconBackgroundColor: .systemPink) {
                print("Help & feedback tapped")
            }),
            
            .staticCell(model: SettingsOption(
                title: "Как работает Кинчик",
                icon: UIImage(systemName: "questionmark.app.fill"),
                iconBackgroundColor: .systemYellow) {
            }),
            
            .staticCell(model: SettingsOption(
                title: "Payment",
                icon: UIImage(systemName: "creditcard.fill"),
                iconBackgroundColor: .systemGreen) {
            }),
            
            .staticCell(model: SettingsOption(
                title: "Saved",
                icon: UIImage(systemName: "play.rectangle"),
                iconBackgroundColor: .systemOrange) {
            }),
            
        ]))
    }
}

// MARK: - Extension Table Delegate/DataSource
extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
            
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
            
            
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .switchCell(let model):
            model.handler()
        case .staticCell(let model):
            model.handler()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
