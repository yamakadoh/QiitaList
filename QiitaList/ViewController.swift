//
//  ViewController.swift
//  QiitaList
//
//  Created by yamakadoh on 4/11/15.
//  Copyright (c) 2015 yamakadoh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var model: MyModel? // 名前これでいいのか？シングルトンにしたほうがいい？
    
    override func loadView() {
        view = MyView(frame: SCREEN_SIZE)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        model = MyModel()
        (view as MyView).model = self.model
        model!.getQiitaList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

