import UIKit


class ListCompanyController: UIViewController{
    private let companyTableView: UITableView = {
           let tableView = UITableView()
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()
//    Creaty company array
   
    struct Device {
        let title: String
        let category: String
    }

    var companies = [Category]()
    var listaCompanias = companiesManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaCompanias.delegador = self
        listaCompanias.seeCompany()
        
        companyTableView.delegate = self
        companyTableView.dataSource = self
        companyTableView.backgroundColor = .white
        companyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        companyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(companyTableView)
                
    NSLayoutConstraint.activate([
    companyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    companyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    companyTableView.topAnchor.constraint(equalTo: view.topAnchor),
    companyTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ])
    }
}

extension ListCompanyController: dataCompanyManagerDelegate{
    
    func foundOfferCompany(oferta: [Category]) {
        print(oferta)
        let nombre = oferta.first?.id
        
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for value in oferta{
            let nombre = value.id
            let firstAction: UIAlertAction = UIAlertAction(title: nombre, style: .default)
    
            actionSheetController.addAction(firstAction)
        }
        // create an action
      
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }

        // add actions
        
        actionSheetController.addAction(cancelAction)


        DispatchQueue.main.async {
            self.present(actionSheetController, animated: true) {
                print("option menu presented")
            }
        
        }
    
    }
    
    func showCompaniesData(list: [Category]) {
        companies = list
        DispatchQueue.main.async {
            self.companyTableView.reloadData()
        }
    }
    
}

extension ListCompanyController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listaCompanias.seeOffersCompany(type: self.companies[indexPath.row].id)
    }
    
}
    
    

extension ListCompanyController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return companyArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All offers by company"
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = companies[indexPath.row].attributes.name
        listContentConfiguration.secondaryText = companies[indexPath.row].id
               
                
        cell.contentConfiguration = listContentConfiguration
        
                return cell

    }
    
}

