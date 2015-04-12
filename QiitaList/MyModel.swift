//
//  MyModel.swift
//  QiitaList
//
//  Created by yamakadoh on 4/11/15.
//  Copyright (c) 2015 yamakadoh. All rights reserved.
//

import UIKit

class MyModel: NSObject, UITableViewDataSource, UITableViewDelegate {
    var objects = NSMutableArray()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        
        if objects.count > 0 {
            if let title = objects[indexPath.row] as? String {
                cell.textLabel?.text = title
            }
        }
        
        return cell
    }
    
    func getQiitaList() {
        let url = NSURL(string: URL_QIITA_LIST)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            if data.length <= 0 {
                println("data size is 0")
                return
            }
            
            // JSONデータを辞書に変換する
            let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            //println("dictionary=\(jsonObject)")   // 取得データの確認
            
            if let statusesArray = jsonObject as? NSArray {
                for element in statusesArray {
                    if let entry = element as? NSDictionary {
                        if let title = entry["title"] as? String {
                            //self.objects.insertObject(title, atIndex: 0)
                            self.objects.addObject(title)
                        }
                    }
                }
                //println(self.objects)
            }
            
            // 完了通知を送る
            dispatch_async(dispatch_get_main_queue(), { // メインスレッドで通知を送らなかったら更新に時間がかかったので。
                NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_COMPLETE_GET_QIITA, object: nil)
            })
        })
        task.resume()
    }
}
