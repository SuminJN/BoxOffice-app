import UIKit

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let movieNm: String
    let salesAcc: String
    let audiAcc: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=0e7f254bab2dfc9322db78fa86cb3001&targetDt="
    var movieData: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        movieURL += getYesterdayString()
        getData()
    }
    
    func getYesterdayString() -> String {
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let yymmdd = yesterdayDate.description.prefix(10).components(separatedBy: ["-"]).joined()
        return yymmdd
    }
    
    func getData() {
        guard let url = URL(string: movieURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            guard let JSONdata = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                self.movieData = decodedData
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        cell.salesAcc.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].salesAcc
        cell.audiAcc.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].audiAcc
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }
    
}

