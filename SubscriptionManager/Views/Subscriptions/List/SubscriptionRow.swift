//
//  SubscriptionRow.swift
//  SubscriptionManager
//
//  Created by Aitor Zubizarreta on 29/09/2020.
//  Copyright © 2020 Aitor Zubizarreta. All rights reserved.
//

import SwiftUI

struct SubscriptionRow: View {
    
    //MARK: - Properties
    
    @EnvironmentObject var subscriptionsViewModel: SubscriptionsViewModel
    var subscription: Subscription
    var price: String {
        let subscriptionPrice: Float = subscription.price
        let finalPrice: String = String(format: "%.2f €", subscriptionPrice)
        return finalPrice
    }
    private var textColor: Color = Color.clear
    private var backgroundColor: Color = Color.clear
    private var strokeColor: Color = Color.clear
    
    //MARK: - Methods
    
    init(subscription: Subscription) {
        self.subscription = subscription
        
        self.configureUIElements()
    }
    
    ///
    /// Configures the colors of the UI.
    ///
    private mutating func configureUIElements() {
        self.textColor = Color.white
        self.backgroundColor = Color.customRowPistachio
        self.strokeColor = Color.customRowPistachio
    }
    
    //MARK: - View
    
    var body: some View {
        NavigationLink(destination: SubscriptionDetailView(subscription: subscription).environmentObject(self.subscriptionsViewModel)) {
            HStack {
                Image(systemName: "tv")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .foregroundColor(self.textColor)
                Text(subscription.name).font(Font.system(size: 18))
                    .foregroundColor(self.textColor)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                Spacer()
                Text(price).font(Font.system(size: 15))
                    .foregroundColor(self.textColor)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
            .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
            .background(self.backgroundColor)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(self.strokeColor, lineWidth: 2)
            )
        }
    }
}

struct SubscriptionRow_Previews: PreviewProvider {
    static let subscriptionsViewModel = SubscriptionsViewModel()
    
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let subscription: Subscription = Subscription(context: context)
        subscription.name = "Test"
        subscription.price = 9
        
        return SubscriptionRow(subscription: subscription).environmentObject(subscriptionsViewModel)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
