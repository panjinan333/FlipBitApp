//
//  CryptoHomeViewController.swift
//  CryptoApp
//
//  Created by Daniel Stewart on 2/16/20.
//  Copyright © 2020 Instamobile. All rights reserved.
//

import Charts
import UIKit

class CryptoHomeViewController: GenericCollectionViewController {
    let uiConfig: UIGenericConfigurationProtocol
    let dsProvider: FinanceDataSourceProvider
    let allCryptosDataSource: GenericCollectionViewControllerDataSource
    
    init(uiConfig: UIGenericConfigurationProtocol,
         dsProvider: FinanceDataSourceProvider) {
        self.uiConfig = uiConfig
        self.dsProvider = dsProvider
        self.allCryptosDataSource = dsProvider.allCryptosListDataSource
        let layout = LiquidCollectionViewLayout(cellPadding: 0)
        let homeConfig = GenericCollectionViewControllerConfiguration(pullToRefreshEnabled: false,
                                                                         pullToRefreshTintColor: .white,
                                                                         collectionViewBackgroundColor: UIColor(hexString: "#f4f6f9"),
                                                                         collectionViewLayout: layout,
                                                                         collectionPagingEnabled: false,
                                                                         hideScrollIndicators: true,
                                                                         hidesNavigationBar: false,
                                                                         headerNibName: nil,
                                                                         scrollEnabled: true,
                                                                         uiConfig: uiConfig,
                                                                         emptyViewModel: nil)
        super.init(configuration: homeConfig)
        
        // Configuring the Stock Chart
        let dateList: ATCDateList = ATCDateList(dates: [
            ATCChartDate(title: "1D", startDate: Date().yesterday),
            ATCChartDate(title: "1W", startDate: Date().oneWeekAgo),
            ATCChartDate(title: "1M", startDate: Date().oneMonthAgo),
            ATCChartDate(title: "3M", startDate: Date().threeMonthsAgo),
            ATCChartDate(title: "1Y", startDate: Date().oneYearAgo),
            ATCChartDate(title: "All", startDate: Date().infiniteAgo)
        ])
        
        let lineChartViewController = ATCDatedLineChartViewController(dateList: dateList,
                                                                      uiConfig: uiConfig)
        lineChartViewController.delegate = self
        
        let chartViewModel = ViewControllerContainerViewModel(viewController: lineChartViewController,
                                                                 cellHeight: 300,
                                                                 subcellHeight: nil)
        chartViewModel.parentViewController = self
        
        // Configuring crypto list
        let cryptoListVC = CryptoViewController(uiConfig: uiConfig, dsProvider: dsProvider, dataSource: allCryptosDataSource)
        let cryptoListModel = ViewControllerContainerViewModel(viewController: cryptoListVC,
                                                                  subcellHeight: 80)
        cryptoListModel.parentViewController = self
        // Watchlist button
        let watchlistModel = CardFooterModel(title: "View Your Watchlist")
        
        // Setting up the datasource
        self.genericDataSource = GenericLocalHeteroDataSource(items: [chartViewModel,
                                                                         cryptoListModel,
                                                                         watchlistModel])
        self.use(adapter: CardViewControllerContainerRowAdapter(), for: "ViewControllerContainerViewModel")
        self.use(adapter: CardFooterRowAdapter(uiConfig: uiConfig), for: "CardFooterModel")
        
        self.title = "Instacoin"
        
        self.selectionBlock = {[weak self] (navController, object, indexPath) in
            guard let strongSelf = self else { return }
            if let _ = object as? CardFooterModel {
                let vc = WatchlistViewController(uiConfig: uiConfig, dsProvider: dsProvider)
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(UIImage.localImage("search-icon", template: true), for: .normal)
        searchBtn.snp.makeConstraints { (maker) in
            maker.width.equalTo(25)
            maker.height.equalTo(25)
        }
        searchBtn.tintColor = uiConfig.mainThemeBackgroundColor
        searchBtn.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
    
    
    @objc fileprivate func didTapSearch() {
        let searchVC = AssetSearchViewController(uiConfig: uiConfig,
                                                 searchDataSource: dsProvider.cryptoSearchDataSource,
                                                 dsProvider: dsProvider,
                                                 title: "Search Crypto...")
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    fileprivate func lineChartData(chart: LineChart, config: LineChartConfiguration) -> LineChartData {
        var lineChartEntry = [ChartDataEntry]()
        for (index, number) in chart.numbers.enumerated() {
            let value = ChartDataEntry(x: Double(index), y: number)
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: nil)
        line1.colors = [config.lineColor]
        line1.lineWidth = 3
        line1.drawValuesEnabled = false
        line1.mode = .cubicBezier
        line1.circleRadius = 0
        line1.circleHoleRadius = 4
        line1.drawFilledEnabled = true
        let colors: CFArray = [config.gradientStartColor.cgColor, config.gradientEndColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [1.0, 0.0])
        let fill = Fill(linearGradient: gradient!, angle: 90.0)
        
        line1.fill = fill
        let data = LineChartData()
        data.addDataSet(line1)
        return data
    }
}

extension CryptoHomeViewController: ATCDatedLineChartViewControllerDelegate {
    func datedLineChartViewController(_ viewController: ATCDatedLineChartViewController,
                                      didSelect chartDate: ATCChartDate,
                                      titleLabel: UILabel,
                                      chartView: LineChartView ) -> Void {
        // The user just changed the date interval on the chart, so we update the chart as well as all crypto assets
        allCryptosDataSource.loadFirst()
        dsProvider.fetchCryptosChart(for: chartDate) {[weak self] (lineChart) in
            guard let `self` = self else { return }
            if let lineChart = lineChart {
                let config = dsProvider.chartConfig
                chartView.data = self.lineChartData(chart: lineChart, config: config)
                chartView.backgroundColor = config.backgroundColor
                chartView.chartDescription?.enabled = true
                
                chartView.pinchZoomEnabled = false
                chartView.dragEnabled = false
                chartView.setScaleEnabled(false)
                chartView.legend.enabled = false
                chartView.xAxis.enabled = false
                chartView.rightAxis.enabled = true
                chartView.rightAxis.drawGridLinesEnabled = false
                chartView.rightAxis.drawZeroLineEnabled = false
                chartView.rightAxis.drawAxisLineEnabled = false
                chartView.rightAxis.valueFormatter = AbbreviatedAxisValueFormatter()
                chartView.rightAxis.labelTextColor = config.leftAxisColor
                chartView.leftAxis.enabled = false
                
                titleLabel.text = FinanceStaticDataProvider.currencyString + String(Int(lineChart.numbers.last ?? 0.0))
                titleLabel.font = uiConfig.regularFont(size: 30)
                titleLabel.textColor = uiConfig.mainTextColor
            } else {
                chartView.data = nil
            }
        }
    }
}
