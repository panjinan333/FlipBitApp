//
//  FinanceStaticDataProvider.swift
//  FinanceApp
//
//  Created by Florian Marcu on 3/10/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import Charts
import UIKit

var backArrowUnicode = "\u{2190}"

class FinanceStaticDataProvider: NSObject {
    static let walkthroughs = [
        ATCWalkthroughModel(title: "Instacoin", subtitle: "Trade & monitor all cryptocurrencies.", icon: "finance-app-icon-1"),
        ATCWalkthroughModel(title: "Crypto Trading", subtitle: "Buy and sell cryptocurrencies.", icon: "money-bag-empty-icon"),
        ATCWalkthroughModel(title: "Crypto Portfolio", subtitle: "Track your crypto investments across all asset categories.", icon: "expenses-pie-icon"),
        ATCWalkthroughModel(title: "Market News", subtitle: "Stay on top of the crypto market by reading cryptocurrency news.", icon: "news-icon"),
        ATCWalkthroughModel(title: "Accounts", subtitle: "Link all of accounts to manage them in a single app.", icon: "accounts-list-icon"),
        ATCWalkthroughModel(title: "Get Notified", subtitle: "Receive notifications and updates on crypto movements.", icon: "bell-icon"),
        ]

    static let notifications: [ATCNotification] = [
        ATCNotification(category: "DEPOSIT RECEIVED", content: "We received your deposit of $5,000. You can start trading.", icon: "calendar-grid-icon", isNotSeen: true, createdAt: Date().fiveHoursAgo),
        ATCNotification(category: "ETH SELL", content: "You just sold 5 $ETH for $300 each.", icon: "coins-filled-icon", isNotSeen: true, createdAt: Date().twoDaysAgo),
        ATCNotification(category: "PORTFOLIO MILESTONE", content: "Congratulations! Your crypto net worth just surpassed $10,000!", icon: "caret-icon", isNotSeen: false, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "LTC RECEIVED", content: "You just received 20 LTC from 0x23432fewf32f2.", icon: "bubbles-icon", isNotSeen: true, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "BTC BUY", content: "You've just bought 53 $BTC for $5,123 each.", icon: "customers-icon", isNotSeen: true, createdAt: Date().twoDaysAgo),
        ATCNotification(category: "DEPOSI RECEIVEDT", content: "A deposit of $250 is scheduled for Mar 29 into your Instacoin account.", icon: "binoculars-icon", isNotSeen: false, createdAt: Date().threeDaysAgo),
        ATCNotification(category: "BCT BUY", content: "You've just bought 139 $BTC for $3,123 each.", icon: "customers-icon", isNotSeen: false, createdAt: Date().fourDaysAgo),
        ]

    static let numericKeys: [ATCKeyboardKey] = [
        ATCKeyboardKey(value: "1", displayValue: "1"),
        ATCKeyboardKey(value: "2", displayValue: "2"),
        ATCKeyboardKey(value: "3", displayValue: "3"),
        ATCKeyboardKey(value: "4", displayValue: "4"),
        ATCKeyboardKey(value: "5", displayValue: "5"),
        ATCKeyboardKey(value: "6", displayValue: "6"),
        ATCKeyboardKey(value: "7", displayValue: "7"),
        ATCKeyboardKey(value: "8", displayValue: "8"),
        ATCKeyboardKey(value: "9", displayValue: "9"),
        ATCKeyboardKey(value: ".", displayValue: "."),
        ATCKeyboardKey(value: "0", displayValue: "0"),
        ATCKeyboardKey(value: backArrowUnicode, displayValue: backArrowUnicode),
        ]

    static let porfolioChart = PieChart(entries: [
        PieChartDataEntry(value: 25, label: "BTC"),
        PieChartDataEntry(value: 19, label: "LTC"),
        PieChartDataEntry(value: 30, label: "ETH"),
        PieChartDataEntry(value: 10, label: "XRP"),
        PieChartDataEntry(value: 10, label: "XLM"),
        PieChartDataEntry(value: 18, label: "LINK"),
        ],
                                           name: "",
                                           format: "%.00f%%",
                                           descriptionText: "")

    static let barChart = BarChart(groups: [BarChartGroup(numbers: [4000, 5500, 7400, 6500], name: "United States"),
                                               BarChartGroup(numbers: [4000, 5000, 6000, 5500], name: "United Kingdom"),
                                               BarChartGroup(numbers: [4400, 4900, 5500, 7200], name: "India")],
                                      name: "Revenue by Country",
                                      labels: ["Q4 17", "Q1", "Q2", "Q3"],
                                      valueFormat: "$%.00f")

    static let netWorthNumbers: [Double] = [7000, 7500, 6900, 7300, 7300, 7100, 7200,
                                            6800, 8000, 8100, 7900, 8500, 9000, 7000, 9500, 11000,
                                            10500, 10000, 9500, 9300, 9200, 10000, 10500, 10600, 11000,
                                            12000, 11500, 11500, 11500, 11300, 10500,
                                            11000, 10600, 10500, 9200, 10000]
    static var lineChart: LineChart {
        return LineChart(numbers: netWorthNumbers.map({$0 + Double.random(in: -2000 ..< 2000)}), name: "Net Worth")
    }
    static let currencyString = "$"
    
    static let cryptos = [
        ATCFinanceAsset(title: "Bitcoin",
                        ticker: "BTC",
                        priceChange: "15.25%",
                        isPositive: true,
                        price: "$3900",
                        color: "#1CA1F2",
                        logoURL: "https://en.bitcoin.it/w/images/en/2/29/BC_Logo_.png"),
        ATCFinanceAsset(title: "Ethereum",
                        ticker: "ETH",
                        priceChange: "2.65%",
                        isPositive: true,
                        price: "$157.08",
                        color: "#1CA1F2",
                        logoURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvjn_08cw8NSecUE2S-NiSdQ_LqO_nhB-NGCZjgqWnIhZNbBkd"),
        ATCFinanceAsset(title: "Litecoin",
                        ticker: "LTC",
                        priceChange: "7.95%",
                        isPositive: false,
                        price: "$59.94",
                        color: "#1CA1F2",
                        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Litecoin_Logo.jpg/600px-Litecoin_Logo.jpg"),
        ATCFinanceAsset(title: "Bitcoin Cash",
                        ticker: "BCH",
                        priceChange: "8.43%",
                        isPositive: true,
                        price: "$147.17",
                        color: "#1CA1F2",
                        logoURL: "https://www.macobserver.com/wp-content/uploads/2017/10/bitcoin-cash-logo-plain-1024x538.jpg"),
        ATCFinanceAsset(title: "Ripple",
                        ticker: "XRP",
                        priceChange: "2.17%",
                        isPositive: true,
                        price: "$0.42",
                        color: "#1CA1F2",
                        logoURL: "https://banner2.kisspng.com/20180516/aeq/kisspng-ripple-cryptocurrency-exchange-investor-blockchain-5afc090ea32540.2105706115264668306683.jpg"),
        ATCFinanceAsset(title: "Stellar Lumens",
                        ticker: "XLM",
                        priceChange: "3.83%",
                        isPositive: true,
                        price: "$0.11",
                        color: "#1CA1F2",
                        logoURL: "https://www.stellar.org/wp-content/themes/stellar/favicon/rocket-180x180.png"),
        ATCFinanceAsset(title: "EOS",
                        ticker: "EOS",
                        priceChange: "2.98%",
                        isPositive: true,
                        price: "$6.30",
                        color: "#1CA1F2",
                        logoURL: "https://cdn2.iconfinder.com/data/icons/cryptocurrency-5/100/cryptocurrency_blockchain_crypto-14-512.png"),
        ATCFinanceAsset(title: "ChainLink",
                        ticker: "LINK",
                        priceChange: "46.68%",
                        isPositive: true,
                        price: "$4.31",
                        color: "#1CA1F2",
                        logoURL: "https://s2.coinmarketcap.com/static/img/coins/64x64/1975.png"),
        ATCFinanceAsset(title: "Ethereum Classic",
                        ticker: "ETC",
                        priceChange: "2.91%",
                        isPositive: true,
                        price: "$8.20",
                        color: "#1CA1F2",
                        logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Ethereum_Classic_Logo.svg/800px-Ethereum_Classic_Logo.svg.png"),
        ATCFinanceAsset(title: "Zcash",
                        ticker: "ZEC",
                        priceChange: "-0.97%",
                        isPositive: false,
                        price: "$113.17",
                        color: "#1CA1F2",
                        logoURL: "https://z.cash/wp-content/uploads/2018/10/zcash-logo-fullcolor-512sq.png"),

    ]

    static var url = "https://www.coindesk.com/jpmorgan-ceo-dimon-said-crypto-companies-want-to-eat-our-lunch"
    static var news = [
        ATCFinanceNewsModel(title: "JPMorgan CEO Dimon Says Crypto Companies ‘Want to Eat Our Lunch’",
                            publication: "Coindesk",
                            createdAt: Date().twoHoursAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Billionaire Investor Henry Kravis Makes First Crypto Investment",
                            publication: "CNBC", createdAt: Date().twoDaysAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Binance Talking to Facebook About Libra Listing: Reports",
                            publication: "Coindesk", createdAt: Date().oneWeekAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Irish Crypto Exchange Bitsane May Have Disappeared With Users’ Funds",
                            publication: "Cointelegraph", createdAt: Date().oneWeekAgo,
                            url: url),
        ATCFinanceNewsModel(title: "A Wannabe Netflix Raised $575 Million on Ethereum – Then Ditched Crypto",
                            publication: "Coindesk", createdAt: Date().oneMonthAgo,
                            url: url),
        ATCFinanceNewsModel(title: "Bitcoin Heading for Fifth Month of Gains Despite Price Correction",
                            publication: "Bloomberg", createdAt: Date().oneMonthAgo,
                            url: "https://www.coindesk.com/bitcoin-heading-for-fifth-month-of-gains-despite-price-correction"),
        ATCFinanceNewsModel(title: "Facebook’s Libra Crypto Code Draws Critiques and Clones",
                            publication: "Bloomberg", createdAt: Date().oneMonthAgo,
                            url: "https://www.coindesk.com/facebooks-libra-crypto-code-draws-critiques-and-clones"),
        ATCFinanceNewsModel(title: "Ethereum Co-Founder’s Polkadot Closes Token Sale, Claims $1.2 Billion Valuation",
                            publication: "Crypto News", createdAt: Date().oneMonthAgo,
                            url: "https://www.coindesk.com/facebooks-libra-crypto-code-draws-critiques-and-clones"),
        ATCFinanceNewsModel(title: "Bitcoin Price Takes Another Tumble, Shedding Nearly $1K in 20 Minutes",
                            publication: "Bloomberg", createdAt: Date().oneMonthAgo,
                            url: "https://www.coindesk.com/bitcoin-price-takes-another-tumble-shedding-nearly-1000-in-20-minutes"),
        ]

    static var portfolioCashAccounts: [FinanceAccount] = [
        FinanceAccount(title: "Personal Savings",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        FinanceAccount(title: "BofA Checkings",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Bank of America"),
        FinanceAccount(title: "Robinhood Cash",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        FinanceAccount(title: "Coinbase USD",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        FinanceAccount(title: "BofA Savings",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Bank of America"),
    ]

    static var portfolioInvestmentsAccounts: [FinanceAccount] = [
        FinanceAccount(title: "Personal Investment",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        FinanceAccount(title: "Robinhood Personal",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        FinanceAccount(title: "Personal crypto",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        FinanceAccount(title: "401(K)",
                          color: "#342323",
                          logoURL: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Fidelity"),
        FinanceAccount(title: "231 Brokerage",
                          color: "#342323",
                          logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png",
                          amount: "$41,802",
                          isPositive: true,
                          institution: "Charles Schwab"),
        ]

    static var portfolioLiabilitiesAccounts: [FinanceAccount] = [
        FinanceAccount(title: "Travel Credit Card",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$1,200",
                          isPositive: true,
                          institution: "Bank of America"),
        FinanceAccount(title: "American Express basic",
                          color: "#342323",
                          logoURL: "https://blockchainstocks.com/wp-content/uploads/2018/08/American-Express_Pentagram_Boteco-Design_04-696x522.jpg",
                          amount: "$500",
                          isPositive: true,
                          institution: "American Express"),
        FinanceAccount(title: "Saphire Reserved",
                          color: "#342323",
                          logoURL: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png",
                          amount: "$2,114",
                          isPositive: true,
                          institution: "Chase Bank"),
        ]

    static var bankAccounts: [FinanceAccount] = [
        FinanceAccount(title: "Personal Investment",
                          color: "#342323",
                          logoURL: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png",
                          amount: "$9,2875",
                          isPositive: true,
                          institution: "Wealthfront"),
        FinanceAccount(title: "Robinhood Personal",
                          color: "#342323",
                          logoURL: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg",
                          amount: "$7,123",
                          isPositive: true,
                          institution: "Robinhood"),
        FinanceAccount(title: "Personal crypto",
                          color: "#342323",
                          logoURL: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545",
                          amount: "$15,712",
                          isPositive: true,
                          institution: "Coinbase Pro"),
        FinanceAccount(title: "401(K)",
                          color: "#342323",
                          logoURL: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg",
                          amount: "$12,030",
                          isPositive: true,
                          institution: "Fidelity"),
        FinanceAccount(title: "231 Brokerage",
                          color: "#342323",
                          logoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png",
                          amount: "$41,802",
                          isPositive: true,
                          institution: "Charles Schwab"),
        FinanceAccount(title: "Travel Credit Card",
                          color: "#342323",
                          logoURL: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg",
                          amount: "$1,200",
                          isPositive: true,
                          institution: "Bank of America"),
        FinanceAccount(title: "American Express basic",
                          color: "#342323",
                          logoURL: "https://blockchainstocks.com/wp-content/uploads/2018/08/American-Express_Pentagram_Boteco-Design_04-696x522.jpg",
                          amount: "$500",
                          isPositive: true,
                          institution: "American Express"),
        FinanceAccount(title: "Saphire Reserved",
                          color: "#342323",
                          logoURL: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png",
                          amount: "$2,114",
                          isPositive: true,
                          institution: "Chase Bank"),
        ]
    
    static var transactions: [ATCFinanceTransaction] = [
        ATCFinanceTransaction(title: "Proper SF Hotel San Francisco", isPositive: false, price: "$55.00", date: Date()),
        ATCFinanceTransaction(title: "The Grind Cafe San Francisco", isPositive: false, price: "$26.39", date: Date().twoHoursAgo),
        ATCFinanceTransaction(title: "Payment Received - Mark Cuban", isPositive: true, price: "$14.99", date: Date().yesterday),
        ATCFinanceTransaction(title: "Prime Video * MW30C9AK", isPositive: false, price: "$14.99", date: Date().yesterday),
        ATCFinanceTransaction(title: "Chez Maman West CA", isPositive: false, price: "$72.00", date: Date().yesterday),
        ATCFinanceTransaction(title: "Netflix.com CA", isPositive: false, price: "$7.99", date: Date().twoDaysAgo),
        ATCFinanceTransaction(title: "Payment Received - Instamobile", isPositive: true, price: "$99.00", date: Date().yesterday),
        ATCFinanceTransaction(title: "Bank of America Credit Card Bill", isPositive: false, price: "$1771.23", date: Date().oneWeekAgo),
        ATCFinanceTransaction(title: "Safeway Groceries", isPositive: false, price: "$89.05", date: Date().oneWeekAgo),
        ATCFinanceTransaction(title: "Uber.com Ride sharing", isPositive: false, price: "$28.74", date: Date().oneMonthAgo),
        ATCFinanceTransaction(title: "Bar & Lounge SFO", isPositive: false, price: "$59.65", date: Date().oneMonthAgo),
        ]

    static var assetPosition = ATCFinanceAssetPosition(title: "Your Position",
                                                       shares: 5,
                                                       equity: "$955.00",
                                                       avgCost: "171.46",
                                                       portfolioDiversity: "7.12%",
                                                       totalReturn: "+$97.71 (+11.40%)",
                                                       todayReturn: "-$20.45 (-2.10%)")

    static var assetStats = ATCFinanceAssetStats(open: "195.30",
                                                 high: "197.69",
                                                 low: "190.79",
                                                 wk52High: "233.47",
                                                 wk52Low: "142.00",
                                                 volume: "19.49M",
                                                 avgVol: "32.65M",
                                                 mktCap: "903.63B",
                                                 peRatio: "15.71",
                                                 divYield: "1.20")

    static var institutions = [
        ATCFinanceInstitution(title: "Chase Bank", imageUrl: "https://uponarriving.com/wp-content/uploads/2016/02/Chase-Logo-300x270.png"),
        ATCFinanceInstitution(title: "Fidelity NetBenefits", imageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg"),
        ATCFinanceInstitution(title: "Wells Fargo Bank", imageUrl: "https://www.wfae.org/sites/wfae/files/styles/x_large/public/201901/wells-logo.jpg"),
        ATCFinanceInstitution(title: "Vanguard", imageUrl: "https://i1.wp.com/millennialmoney.com/wp-content/uploads/2015/09/vanguard.logo_.png"),
        ATCFinanceInstitution(title: "Fidelity", imageUrl: "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e5/b4/12/e5b412b9-e3e6-2656-f68b-cff004ab695c/AppIcon-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-9.png/246x0w.jpg"),
        ATCFinanceInstitution(title: "Capital One", imageUrl: "https://uponarriving.com/wp-content/uploads/2017/11/CapitalOne.png"),
        ATCFinanceInstitution(title: "Ally Financial", imageUrl: "https://pbs.twimg.com/profile_images/762644570568024064/Az3Nca2s_400x400.jpg"),
        ATCFinanceInstitution(title: "Wealthfront", imageUrl: "https://theme.zdassets.com/theme_assets/586236/49e4904c4910a8ebf63b67d41f9b98b6b0933275.png"),
        ATCFinanceInstitution(title: "Robinhood", imageUrl: "https://c93fea60bb98e121740fc38ff31162a8.s3.amazonaws.com/wp-content/uploads/2017/04/robinhood.jpg"),
        ATCFinanceInstitution(title: "Real Estate", imageUrl: "https://img1-placeit-net.s3-accelerate.amazonaws.com/uploads/stage/stage_image/21703/large_thumb_placeit__15_.jpg"),
        ATCFinanceInstitution(title: "Charles Schwab", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Charles_Schwab_Corporation_logo.svg/220px-Charles_Schwab_Corporation_logo.svg.png"),
        ATCFinanceInstitution(title: "Bank of America", imageUrl: "https://static1.squarespace.com/static/5634e954e4b0f9cec0c16373/t/5bcc7f24085229820cd48c9e/1540128588808/Bofa-logo.jpg"),
        ATCFinanceInstitution(title: "Coinbase", imageUrl: "https://assets.coingecko.com/markets/images/23/large/fe290a14-ac8f-4c90-9aed-5e72abf271f0.jpeg?1527171545"),
        ]
}
