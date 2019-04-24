//
//  ViewController.swift
//  JWLoadingHUD
//
//  Created by 10126121@qq.com on 04/21/2019.
//  Copyright (c) 2019 10126121@qq.com. All rights reserved.
//

import UIKit
import JWLoadingHUD

class ViewController: UIViewController {
    
    lazy var titles = ["显示(加载图+字, 背景可操作)",
                       "显示(图文, 背景可操作)",
                       "显示(图, 背景可操作)",
                       "显示(文, 背景可操作)",
                       "显示(加载图+字, 背景不可操作, 3s后隐藏)",
                       "隐藏",
                       "显示背景蒙层(颜色)",
                       "显示背景蒙层(渐变色)",
                       "显示背景蒙层(高斯模糊)",
    ]
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(listView)
        listView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        listView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
}

/// 数据源
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        return cell
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    /// 点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            
            view.showHUD(mode: JWHUDMode.loading("正在加载正在加载正在加载正在加载正在加载正在加载"),
                                 hiddenDelay: 2.0)
            
            break
        case 1:
            view.showHUD(mode: JWHUDMode.imageText(UIImage(named: "LoadingSuccessHUD"), "加载成功"),
                                 hiddenDelay: 2.0)
            break
        case 2:

            let config = JWHUDStyle()
            config.minSize = CGSize(width: 140, height: 120)
            config.backgroundColor = UIColor(white: 0, alpha: 0.95)
            view.showHUD(style: config,
                         mode: JWHUDMode.imageText(UIImage(named: "LoadingFailHUD"), nil),
                         hiddenDelay: 2.0)
            break
        case 3:
            
            let config = JWHUDStyle()
            config.minSize = CGSize(width: 140, height: 120)
            config.backgroundColor = UIColor(white: 0, alpha: 0.95)
            view.showHUD(style: config,
                         mode: JWHUDMode.imageText(nil, "加载文字"),
                         hiddenDelay: 2.0)
            
            break
            
        case 4:
            
            let config = JWHUDStyle()
            view.showHUD(style: config,
                         mode: JWHUDMode.loading("正在加载"),
                         hiddenDelay: 3.0)
            
            break
        case 5:
            view.dismissHUD(animated: true, afterDelay: 0.0)
            break
        case 6:
            
            let config = JWHUDStyle()
            config.markType = .color(UIColor.red.withAlphaComponent(0.2), isUserInteractionEnabled: true)
            view.showHUD(style: config,
                         mode: JWHUDMode.loading("正在加载"),
                         hiddenDelay: 3.0)
            break
        case 7:
            
            let config = JWHUDStyle()
            config.markType = JWLoadingHUDMarkType.darkGradient
            view.showHUD(style: config,
                         mode: JWHUDMode.loading("正在加载"),
                         hiddenDelay: 3.0)
            break
        case 8:
            
            let config = JWHUDStyle()
            config.markType = .blur(style: UIBlurEffect.Style.light, tintColor: UIColor.red.withAlphaComponent(0.2))
            view.showHUD(style: config,
                         mode: JWHUDMode.loading("正在加载"),
                         hiddenDelay: 3.0)
            break
            
        default:
            break
        }
        
        
    }
}

