//
//  ListViewController.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//

import UIKit
import CoreData
class ListViewController: UIViewController {
    
    var emp : Employee!
    var per : Person!
    var perarr : [Person] = []
    var searcharr : [Person] = []
    var flagSection : [Bool] = []
    @IBOutlet var search_txt: UISearchBar!
    @IBOutlet var list_tbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let mcontext = app.persistentContainer.viewContext
        let req = NSFetchRequest<Person>.init(entityName: "Person")
        do{
            try perarr = mcontext.fetch(req)
            perarr.sort {
                $0.name! < $1.name!
            }
            for _ in perarr
            {
                flagSection.append(false)
            }
            list_tbl.reloadData()
        }catch{
            print(error)
        }
    }
}

//MARK: TableView Delegate & Datasource Methods
extension ListViewController:UITableViewDelegate,UITableViewDataSource {
    
    @objc func headSelect(_ sender:UIButton) {
        if(flagSection[sender.tag]) {
            flagSection[sender.tag] = false
        }
        else {
            flagSection[sender.tag] = true
        }
        list_tbl.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !search_txt.text!.isEmpty {
            return searcharr.count
        }
        return perarr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView()
        view1.backgroundColor = UIColor(red: 62/255, green: 149/255, blue: 226/255, alpha: 1)
        let btn = UIButton(frame: CGRect(x: 0, y: 10, width: list_tbl.frame.size.width, height:20))
        btn.titleLabel?.textColor = .white
        if !search_txt.text!.isEmpty {
            btn.setTitle(searcharr[section].name, for: .normal)
        }
        else {
            btn.setTitle(perarr[section].name, for: .normal)
        }
        btn.tag = section
        btn.addTarget(self, action: #selector(headSelect(_:)), for: .touchUpInside)
        view1.addSubview(btn)
        return view1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! searchTableViewCell
        
        if(flagSection[indexPath.section]) {
            if !search_txt.text!.isEmpty {
                per = searcharr[indexPath.section]
            }
            else {
                per = perarr[indexPath.section]
            }
            emp = per.emp_detail
            cell.name_txt.text = "Name : \(per.name!)"
            cell.age_txt.text = "Age : \(per.age!)"
            cell.desig_txt.text = "Designation : \(emp.designation!)"
            cell.sal_txt.text = "Salary : \(emp.salary!)"
            cell.dept_txt.text = "Department : \(emp.department!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(!flagSection[indexPath.section]) {
            return 0
        }
        return 138
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let app = UIApplication.shared.delegate as! AppDelegate
            let mcontext = app.persistentContainer.viewContext
            if !search_txt.text!.isEmpty {
                mcontext.delete(searcharr[indexPath.row])
            }
            else {
                mcontext.delete(perarr[indexPath.row])
            }
            getData()
        }
    }
    
    func searching() {
        if !search_txt.text!.isEmpty {
            searcharr = []
            for i in perarr {
                if (i.name!.hasPrefix(search_txt.text!)) {
                    searcharr.append(i)
                }
            }
        }
        getData()
    }
}

//MARK: SearchBarDelegate
extension ListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searching()
    }
}
