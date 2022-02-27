//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Theuner, Heiko on 04.02.21.
//

import UIKit
import Combine

class ViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pagerTextField: UITextField!
    
    private let id = "1118635128"
    
    private var viewModel: AdViewModel?
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let viewModel = AdViewModel(with: id)
        self.viewModel = viewModel
        
        // observing state
        viewModel.$state
            .sink { [weak self] state in
                self?.render(state)
            }
            .store(in: &cancellable)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowImage":
            if let vc = segue.destination as? ImageViewController,
                let index = sender as? Int,
                let url = viewModel?.smallImageViewURLs[index] {
                vc.imageURL = url
            }
        default:
            break
        }
    }
    
    // MARK: - Private
    private func render(_ state: AdViewModel.State) {
        switch state {
        case .isLoading:
            refreshUI(isLoading: true)
        case .failed, .loaded: 
            refreshUI(isLoading: false)
        }
    }

    private func refreshUI(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.title = "please wait..."
                // start loading spinner
                self.loader.startAnimating()
            } else {
                // stop loading spinner
                self.loader.stopAnimating()
                // evaluate and load data in tableview
                if let _ = self.viewModel {
                    self.pagerTextField.text = "1/\(self.viewModel?.smallImageViewURLs.count ?? 0)"
                    self.collectionView.reloadData()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UIScrollViewDelegate{
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageWidth = self.collectionView.frame.size.width
            let currentPage = Int(self.collectionView.contentOffset.x / pageWidth) + 1
            pagerTextField.text = "\(currentPage)/\(viewModel?.smallImageViewURLs.count ?? 0)"
        }
    }

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.smallImageViewURLs.count ?? 0 // there are no good images after the first three and library behaves in a wrong manner. To fix the library it will take hours, so I am going with
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            if let url = viewModel?.smallImageViewURLs[indexPath.row] {
                cell.setup(with: url)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowImage", sender: indexPath.row)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel?.attributes.count ?? 0
        case 2:
            return 1
        case 3:
            return viewModel?.documents.count ?? 0
        case 4:
            return 1
        default:
            return 0
        }
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70)
        let view = UIView(frame: frame)

        let greyFrame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 10)
        let greyView = UIView(frame: greyFrame)
        greyView.backgroundColor = .groupTableViewBackground
        view.addSubview(greyView)
        
        let label = UILabel(frame: CGRect(x: 20, y: 30, width: 200, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 24)
        var text = ""
        switch section {
        case 0:
            text = ""
        case 1:
            text = "Details"
        case 2:
            text = "Ausstattung"
        case 3:
            text = "Weitere Informationen"
        case 4:
            text = "Beschreibung"
        default:
            break
        }
        label.text = text
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as? DetailsCell {
                if let viewModel = self.viewModel {
                    cell.setup(with: viewModel)
                    cell.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat.greatestFiniteMagnitude)
                    return cell
                }
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeCell") as? AttributeCell {
                if let viewModel = self.viewModel {
                    let attribute = viewModel.attributes[indexPath.row]
                    cell.setup(with: attribute)
                    return cell
                }
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell") as? FeatureCell {
                if let viewModel = self.viewModel {
                    cell.setup(with: viewModel.features)
                    return cell
                }
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell") as? DocumentCell {
                if let viewModel = self.viewModel {
                    let document = viewModel.documents[indexPath.row]
                    cell.setup(with: document)
                    return cell
                }
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell") as? DescriptionCell {
                if let viewModel = self.viewModel {
                    cell.setup(with: viewModel.description)
                    return cell
                }
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch indexPath.section {
        case 3:
            return indexPath
        default:
           return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 3:
            let document = viewModel?.documents[indexPath.row]
            if let link = document?.link, let url = URL(string: link){
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        default:
            break
        }
    }
    
}

