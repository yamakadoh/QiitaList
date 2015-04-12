//
//  MyView.swift
//  QiitaList
//
//  Created by yamakadoh on 4/11/15.
//  Copyright (c) 2015 yamakadoh. All rights reserved.
//

import UIKit

class MyView: UIView {
    var statusBarView: UIView?
    var listView: UITableView?
    var model: MyModel? {
        didSet {
            listView!.dataSource = model
            listView!.delegate = model  // モデルでいいのか？
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        statusBarView = UIView(frame: CGRectMake(0, 0, frame.width, STATUSBAR_HEIGHT))
        statusBarView!.backgroundColor = UIColor.whiteColor()
        addSubview(statusBarView!)
        
        listView = UITableView(frame: CGRectMake(0, STATUSBAR_HEIGHT, frame.width, frame.height - STATUSBAR_HEIGHT))
        listView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        addSubview(listView!)
        
        addObserver()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "listUpdate:", name: NOTIFICATION_COMPLETE_GET_QIITA, object: nil)
    }
    
    private func removeObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func listUpdate(notification: NSNotification) {
        listView?.reloadData()
    }
    
    deinit {
        removeObserver()
    }
}
