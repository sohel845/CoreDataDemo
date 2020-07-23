//
//  MainViewController.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController {
    
    @IBOutlet var name_txt: UITextField!
    @IBOutlet var age_txt: UITextField!
    @IBOutlet var desc_txt: UITextField!
    @IBOutlet var sal_txt: UITextField!
    @IBOutlet var dept_txt: UITextField!
    @IBOutlet var in_btn: UIButton!
    @IBOutlet var list_tbl: UITableView!
    var emp : Employee!
    var per : Person!
    var perarr : [Person] = []
    var flagSection : [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    func getData() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let mcontext = app.persistentContainer.viewContext
        let req = NSFetchRequest<Person>.init(entityName: "Person")
        do {
            try perarr = mcontext.fetch(req)
            perarr.sort {
                $0.name! < $1.name!
            }
            for _ in perarr {
                flagSection.append(false)
            }
            list_tbl.reloadData()
        }catch{
            print(error)
        }
    }
    
    @IBAction func operation_method(_ sender: Any) {
        if in_btn.titleLabel?.text == "Insert" {
            let app = UIApplication.shared.delegate as! AppDelegate
            let mcontext = app.persistentContainer.viewContext
            emp = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: mcontext) as? Employee
            emp.department = dept_txt.text
            emp.designation = desc_txt.text
            emp.salary = sal_txt.text
            per = NSEntityDescription.insertNewObject(forEntityName: "Person", into: mcontext) as? Person
            per.age = age_txt.text
            per.name = name_txt.text
            per.emp_detail = emp
            app.saveContext()
            clearData()
            getData()
        }
        else {
            let app = UIApplication.shared.delegate as! AppDelegate
            emp.department = dept_txt.text
            emp.designation = desc_txt.text
            emp.salary = sal_txt.text
            per.age = age_txt.text
            per.name = name_txt.text
            per.emp_detail = emp
            app.saveContext()
            in_btn.setTitle("Insert", for: .normal)
            clearData()
            getData()
        }
    }
    func clearData() {
        name_txt.text = ""
        age_txt.text = ""
        sal_txt.text = ""
        desc_txt.text = ""
        dept_txt.text = ""
    }
}

//MARK: TableView Delegate & Datasource Methods
extension MainViewController:UITableViewDelegate,UITableViewDataSource {
    
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
        return perarr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view1 = UIView()
        view1.backgroundColor = UIColor(red: 60/255  , green: 149/255, blue: 226/255, alpha: 1)
        let btn = UIButton(frame: CGRect(x: 0, y: 10, width: list_tbl.frame.size.width, height:20))
        btn.titleLabel?.textColor = .white
        btn.setTitle(perarr[section].name, for: .normal)
        btn.tag = section
        btn.addTarget(self, action: #selector(headSelect(_:)), for: .touchUpInside)
        view1.addSubview(btn)
        return view1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail") as! DetailTableViewCell
        
        if(flagSection[indexPath.section]) {
            per = perarr[indexPath.section]
            emp = per.emp_detail
            cell.name_det.text = "Name : \(per.name!)"
            cell.age_det.text = "Age : \(per.age!)"
            cell.desig_det.text = "Designation : \(emp.designation!)"
            cell.sal_det.text = "Salary : \(emp.salary!)"
            cell.dept_det.text = "Department : \(emp.department!)"
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
            mcontext.delete(perarr[indexPath.row])
            getData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        per = perarr[indexPath.row]
        emp = per.emp_detail
        name_txt.text = per.name
        age_txt.text = per.age
        desc_txt.text = emp.designation
        sal_txt.text = emp.salary
        dept_txt.text = emp.department
        in_btn.setTitle("Update", for: .normal)
    }
    
}
