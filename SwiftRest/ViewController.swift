//
//  ViewController.swift
//  SwiftRest
//
//  Created by Bacem Ben Afia on 13/05/2019.
//  Copyright © 2019 Bacem Ben Afia, A.K.A Pirana. ba.bessem@gmail.com ios/android/jee. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    private var tableView: UITableView!
    
    var nearEarthListVM : NearEarth? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        
        startLoading(nil)
        
        getRemoteData()
 
    }
    
    
    fileprivate func handleResponse(_ result: Result<NearEarthListCall.T, GenericError>) {
        stopLoading()
        switch result {
            
        case .success(_):
            do {
                try self.nearEarthListVM = result.get()
            }
            catch (let err) {
                print(err)
            }
            break
        case .failure(_):
            print(result)
            break
        }
    }
    
    func getRemoteData(){
        
        NearEarthListService.shared.ping { (result) in
            self.handleResponse(result)
        }
        
        
        /*LoginCall(bodyParams: ["userName" : "", "pwd" : ""]).execute(URLSession.shared) { (result) in
         switch result {
         
         case .success(_):
         break
         case .failure(_):
         break
         
         }
         }*/
        
    }
}

/// MARK - UITableView and stuff

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    fileprivate func setUpTableView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nearEarthListVM != nil {
            return (nearEarthListVM?.objectForSection(section: section).count)!
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nearEarthListVM != nil ? (nearEarthListVM?.nearEarthObjects.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nearEarthListVM?.keys[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nearEarthObject = nearEarthListVM?.objectForSection(section: indexPath.section)[indexPath.row]
        return cell
    }
    
}




