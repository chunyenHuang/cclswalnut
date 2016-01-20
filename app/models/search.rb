class Search < ActiveRecord::Base
	def search_orderlists
 
    k="%#{keywords}%"
		#orderlists = Orderlist.all
		orderlists = Orderlist.where(
              '
              ordernumber LIKE ? or 
              order_of LIKE? or 
              setters LIKE? or 
              description LIKE? or
              invoicenumber LIKE ? or
              itemnumber LIKE ? or
              gold LIKE ? or
              category LIKE ? or
              rushnote LIKE ? or
              caddesigners LIKE ? or
              status_factory LIKE? or
              center_carat LIKE ? or
              center_description LIKE ?
              ',k,k,k,k,k,
                k,k,k,k,k,
                k,k) if keywords.present?
    

    
    orderlists = Orderlist.where(["ordernumber LIKE ?", ordernumber ]) if ordernumber.present?
    orderlists = Orderlist.where(["invoicenumber LIKE ?", invoicenumber ]) if invoicenumber.present?
    orderlists = Orderlist.where(["itemnumber LIKE ?", itemnumber ]) if itemnumber.present?

###


		orderlists = Orderlist.where(["category LIKE ?", category]) if category.present?
    orderlists = Orderlist.where(["gold LIKE ?", gold]) if gold.present?
    orderlists = Orderlist.where(["size LIKE ?", size]) if size.present?
    orderlists = Orderlist.where(["customer_id =?", customer_id]) if customer_id.present?
    orderlists = Orderlist.where(["caddesigners LIKE ?", caddesigners ]) if caddesigners.present?
    orderlists = Orderlist.where(["setters LIKE ?", setters ]) if setters.present?
    orderlists = Orderlist.where(["status_factory LIKE ?", status_factory ]) if status_factory.present?
  
    if center_carat.present?
      max_center_carat= (center_carat+0.3).to_f
      min_center_carat= (center_carat-0.3).to_f
      checkcarat = center_carat.to_f
      if center_carat >= 5
        orderlists = Orderlist.where(["center_carat >= ?", checkcarat ])
      else
        orderlists = Orderlist.where(["center_carat <= ?", max_center_carat ]).where(["center_carat >= ?", min_center_carat ])
      end
    end
   
    if from_date != to_date
      orderlists = Orderlist.where(["created_at >= ?", from_date ]).where(["created_at <= ?", to_date ])
    end

    #Something.find(:all, :conditions => [ "BETWEEN ? AND ?", from, to])
		#orderlists = Orderlist.where(["created_at >= LIKE ?", created_at]) if created_at.present?
		#orderlists = Orderlist.where(["created_at <= LIKE ?", updated_at]) if updated_at.present?
		


    return orderlists


	end




end
