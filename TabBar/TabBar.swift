import UIKit

class TabBar: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .systemBackground
        setUpVC()
        
    }
    
    func createViewControllers(for root: UIViewController, title: String) -> UIViewController{

        let navViewController = UINavigationController(rootViewController: root)
        navViewController.tabBarItem.title = title
        navViewController.tabBarItem.image = UIImage.actions
        navViewController.navigationBar.prefersLargeTitles = true
        root.navigationItem.title = title
        return navViewController
    }
    
    func setUpVC(){
//        Definir VC
        
        setViewControllers([createViewControllers(for: CategoryController(), title: "Categories"),createViewControllers(for: ListCompanyController(), title: "Companies")], animated: true)
        
        
    }
    
    
    
}
