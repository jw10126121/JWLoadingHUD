//
//  ViewController.swift
//  JWLoadingHUD
//
//  Created by 10126121@qq.com on 04/21/2019.
//  Copyright (c) 2019 10126121@qq.com. All rights reserved.
//

import UIKit
import MBProgressHUD
import JWLoadingHUD

class ViewController: UIViewController {
    
    lazy var titles = ["普通(加载图+字, 背景可操作)",
                       "普通(图文, 背景可操作)",
                       "普通(图, 背景可操作)",
                       "普通(文, 背景可操作)",
                       "多层(加载图+字, 背景可操作)"
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
            
            view.hudManager.show(mode: JWHUDMode.loading("正在加载正在加载正在加载正在加载正在加载正在加载"),
                                 hiddenDelay: 2.0)
            
            break
        case 1:
            view.hudManager.show(mode: JWHUDMode.imageText(UIImage(named: "LoadingHUDSuccess"), "加载成功"),
                                 hiddenDelay: 2.0)
            break
        case 2:
            view.hudManager.show(mode: JWHUDMode.imageText(UIImage(named: "LoadingHUDFail"), nil),
                                 hiddenDelay: 2.0)
            break
        case 3:
            
            let config = JWHUDStyle()
            config.mode = JWHUDMode.imageText(nil, "加载文字")
            config.minSize = CGSize(width: 140, height: 120)
            config.backgroundColor = UIColor(white: 0, alpha: 0.95)
            view.showHUD(config: config,
                         mode: JWHUDMode.imageText(nil, "加载文字"),
                         hiddenDelay: 2.0)
            
            break
            
        case 4:
            view.showHUD(mode: JWHUDMode.loading("正在加载正在加载正在加载正在加载正在加载正在加载"),
                         animated: true,
                         hiddenDelay: 5.0)
            
            view.showHUD(mode: JWHUDMode.imageText(UIImage(named: "LoadingHUDSuccess"), "加载成功加载成功"),
                         animated: true,
                         hiddenDelay: 3.5)
            
            
            view.showHUD(mode: JWHUDMode.imageText(nil, "正在加载"),
                         animated: true,
                         hiddenDelay: 2.0)
            
            break
            
        default:
            break
        }
        
        
    }
}

