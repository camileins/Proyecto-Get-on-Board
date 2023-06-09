import UIKit

class CategoryController: UIViewController {
    
    private let companyTableView: UITableView = {
           let tableView = UITableView()
           tableView.translatesAutoresizingMaskIntoConstraints = false
           return tableView
       }()

   struct Device {
        let title: String
        let category: String
       
    }

    var categories = [Category]()
    var listaCategoria = categoriesManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listaCategoria.delegador = self
        listaCategoria.seeCategory()
      
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

extension CategoryController: dataManagerDelegate{
    func foundOffer(ofertas: [Category]) {
        print(ofertas)
        let name = ofertas.first?.id
        // create an actionSheet
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for value in ofertas{
            let name = value.id
            let firstAction: UIAlertAction = UIAlertAction(title: name, style: .default)
    
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
    
    func showCategoriesData(list: [Category]) {
        categories = list
        DispatchQueue.main.async {
            self.companyTableView.reloadData()
        }
    }
    
}

extension CategoryController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.listaCategoria.seeOffers(type: self.categories[indexPath.row].id)
    }
    
}

// Tabla con categorias
extension CategoryController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
//        return categories.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All categories"
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        var listContentConfiguration = UIListContentConfiguration.cell()
        listContentConfiguration.text = categories[indexPath.row].attributes.name
//        listContentConfiguration.secondaryText = categories[indexPath.row].title
               
                
        cell.contentConfiguration = listContentConfiguration
        
                return cell

    }
    
}

