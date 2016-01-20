class SearchesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
    @search = Search.new
    #@cads = Orderlist.uniq.pluck(:caddesigners)
    @sets = Orderlist.uniq.pluck(:setters)
    @order_ofs = Orderlist.uniq.pluck(:order_of)
    @customer_select = Customer.order(customer_company: :desc, customer_firstname: :asc)
    @T=nil

  end

  def create
    @search = Search.create(search_params)
    redirect_to @search
    @customer_select = Customer.order(customer_firstname: :asc, customer_company: :desc).all

  end

  def show
    @search = Search.find(params[:id],params[:user_id],params[:customer_id])
    #@search = Search.find(:all, :conditions => [all_conditions, arguments])

  end

private

  def search_params
    params.require(:search).permit(
      :keywords, :category, :gold, :size, :caddesigners, :setters, :customer_id,
      :status_factory, :order_of, :ordernumber, :itemnumber, :invoicenumber,
      :from_date, :to_date, :created_at, :updated_at, :center_carat)
  end
    def sort_column
      Search.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
    end
    
    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end


end
