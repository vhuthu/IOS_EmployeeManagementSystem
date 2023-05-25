//
//  ToDoViewController.swift
//  APIProject
//
//  Created by DA MAC M1 162 on 2023/05/24.
//

import UIKit

class ToDoViewController: UIViewController {
   
    var data = [ToDo]()
    var searchingArray = [ToDo]()
    var searching = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchApiData(URL: "http://localhost:8080/employee"){ result in
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchApiData(URL url: String , completion: @escaping([ToDo]) -> Void){
        
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if data != nil && error == nil{
                do {
                    let parsingData = try JSONDecoder().decode([ToDo].self , from: data!)
                    completion(parsingData)
                }catch{
                    print("parsing error")
                }
            }
        }
        dataTask.resume()
    }
}

extension ToDoViewController: UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching { return searchingArray.count }
        else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell" , for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        if searching {
            cell.textLabel?.text = data[indexPath.row].firstname
            cell.toDoID.text = "\(data[indexPath.row].employeeID)"
            cell.lastNameLabel.text = data[indexPath.row].lastname
            cell.departmentLabel.text = data[indexPath.row].department
        }
        else{
            cell.textLabel?.text = data[indexPath.row].firstname
            cell.toDoID.text = "\(data[indexPath.row].employeeID)"
            cell.lastNameLabel.text = data[indexPath.row].lastname
            cell.departmentLabel.text = data[indexPath.row].department
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchingArray = data.filter {
            $0.firstname.lowercased().contains(searchText.lowercased()) ||
            $0.lastname.lowercased().contains(searchText.lowercased())
            
        }
        searching = !searchText.isEmpty
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            vc?.numLabel = "\(data[indexPath.row].employeeID)"
            vc?.titleLbl = data[indexPath.row].firstname
            vc?.titleLbl2 = data[indexPath.row].lastname
            vc?.departL = data[indexPath.row].department
            
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

