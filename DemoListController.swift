//
//  DemoListController.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

class DemoListController: UIViewController
{
    lazy var tableView:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        title = "Cycling Legend-Alberto Contador"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "BradleyHandITCTT-Bold", size: 20)!,NSAttributedStringKey.foregroundColor : UIColor.blue]
        //BradleyHandITCTT-Bold
        //Georgia-BoldItalic
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        //https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E8%A8%AD%E5%AE%9A%E8%A1%A8%E6%A0%BC%E7%9A%84%E8%83%8C%E6%99%AF%E5%9C%96%E7%89%87-45508aa6f630
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "contador-8.jpg"))
        tableView.backgroundView?.alpha = 0.5
    }
}

// MARK: - tableView delegate / dataSource
extension DemoListController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        var str:String? = nil
        switch indexPath.row {
        case 0:
            str = "Play Local Song"
        case 1:
            str = "Play youtube"
        case 2:
            //str = "支持StoryBoard创建"
            str = "Play photo"
        default:
            str = ""
        }
        cell.textLabel?.text = str
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        //https://github.com/lionhylra/iOS-UIFont-Names
        cell.textLabel?.textColor = UIColor.red
        //cell.textLabel?.font = UIFont(name: "Georgia-Bold", size: 20)
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 32)
        //https://stackoverflow.com/questions/18753411/uitableview-clear-background
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            //navigationController?.pushViewController(FirstViewController(), animated: true)
            //print("0 before")
            navigationController?.pushViewController(TableViewController(), animated: true)
            /*
            if let songListController =
                storyboard?.instantiateViewController(withIdentifier:
                    "songList") {
                present(songListController, animated: true, completion: nil)
                print("0 middle")
            }*/
             //print("0 after")
        case 1:
            //navigationController?.pushViewController(TableController(), animated: true)
            let youtubeListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "youtubelist")
            self.navigationController?.pushViewController(youtubeListController, animated: true)
            
        case 2:
            
            let photoScrollController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "photoScroll")
            self.navigationController?.pushViewController(photoScrollController, animated: true)
            //self.navigationController?.pushViewController(TableController(), animated: true)
            //let SBVC:SBController = UIStoryboard.init(name: "StoryBoardController", bundle: nil).instantiateInitialViewController() as! SBController
            //navigationController?.pushViewController(SBVC, animated: true)
       
        default:
           break
        }
    }
}




