class HomeController < ApplicationController

  def index
    @countries = country_object_list(Country.all)
    @countries = @countries.sort!{|x,y| x.name <=> y.name }
    @country_names = @countries.collect {|c| c.name}
    @unvisits = (@country_names - current_user.visits).sort{|x,y| x <=> y }
  end
  
  def sort_country
    @countries = country_object_list(Country.all)
    @field = params[:field]== 'currency' ? 1 : 0 
    @sort_type = params[:type]
    if @sort_type=='desc'
      @countries.reverse!
      @countries.sort!{|x,y| @field==0 ? (y.name <=> x.name) : (((y.currency ? y.currency['code'] : '') <=> (x.currency ? x.currency['code'] : ''))) }
      @sort_type = 'asc'
    else
      @countries.sort!{|x,y| @field==0 ? (x.name <=> y.name) : (((x.currency ? x.currency['code'] : '') <=> (y.currency ? y.currency['code'] : ''))) }
      @sort_type = 'desc'
    end
    
    respond_to :js
  end
  
  private
    def country_object_list array
      countries = []
      array.each do |arr|
        countries << Country.find_country_by_alpha2(arr[1].downcase)
      end
      countries
    end
end
