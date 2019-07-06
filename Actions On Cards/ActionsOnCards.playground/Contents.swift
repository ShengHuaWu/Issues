import UIKit
import PlaygroundSupport

enum MetricType {
    case text
    case table
    case accessory
}

struct Metric {
    let type: MetricType
    let content: String
}

let metrics = [
    Metric(type: .text, content: "This is a text card."),
    Metric(type: .text, content: "This is anothet text card."),
    Metric(type: .accessory, content: "This is a an accessory card."),
    Metric(type: .table, content: "This is a table card."),
    Metric(type: .accessory, content: "This is another accessory card.")
]

final class CardsViewController: UICollectionViewController {
    private let metrics: [Metric]
    
    init(metrics: [Metric]) {
        self.metrics = metrics
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 375, height: 400)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(highlightItem(_:)))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return metrics.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    
    @objc func highlightItem(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        let point = sender.location(in: collectionView)
        collectionView.indexPathForItem(at: point)
            .flatMap { collectionView.cellForItem(at: $0) }
            .map { $0.backgroundColor = .brown }
    }
}

let cardsViewController = CardsViewController(metrics: metrics)
cardsViewController.view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
PlaygroundPage.current.liveView = cardsViewController.view
