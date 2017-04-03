import UIKit

// NOTE: <---- Look up Sources folder for all the definitions

// Define your view models and conform them to the `ViewModel` protocol
struct ArtistViewModel: ViewModel {
    var reuseIdentifier: String = ArtistRowCell.reuseIdentifier
    let name: String

    init(name: String) {
        self.name = name
    }
}

// Also, make the view models provide a default size of the row
extension ArtistViewModel: Resizable {
    func preferredSize(in rect: CGRect) -> CGSize {
        return CGSize(width: rect.width, height: 150)
    }
}

// When defining your custom cells, make sure you extend them with `Configurable` protocol
final class ArtistRowCell: UITableViewCell, Configurable {
    typealias DataModel = ArtistViewModel

    func configured(with model: ViewModel) -> ArtistRowCell {
        if let viewModel = model as? DataModel {
            textLabel?.text = viewModel.name
        }

        return self
    }
}

// lets try and stay away from subclass-specific code and rather rely on protocol/abstract types
class ArtistTableViewController: UITableViewController {

    // We need some data, lets rely on on any type conforming to the  `ViewModel` protocol
    var dataSource: [ViewModel]!

    override func viewDidLoad() {
        // Lets add some sample data
        dataSource = [ArtistViewModel(name: "50 Cent")]

        // HERE: This method registers cells from separate NIB files,
        // since the table view cells don't really have to be coupled with your storyboard
        tableView.register(ArtistRowCell.self)
        // OTHERWISE you can just register the class with its own reuse identifier:
//      tableView.register(ArtistRowCell.self, forCellReuseIdentifier: ArtistRowCell.reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = dataSource[indexPath.row]

        // Dequeue and cast a cell as `Configrable`, then simply configure it with given view model and return it
        if let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier) as? Configurable {
            return cell.configured(with: viewModel) as! UITableViewCell
        }

        // For consistency, we might want to remind ourselves whether we forget to conform a cell to `Configurable` protocol
        fatalError("Only Confiogurable cells please")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = dataSource[indexPath.row] as? Resizable else {
            return tableView.rowHeight
        }

        return viewModel.preferredSize(in: tableView.frame).height
    }
}
