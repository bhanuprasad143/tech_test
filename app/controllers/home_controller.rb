class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    @country_names = Country.all.collect {|c| c[0]}
    @unvisits = (@country_names - current_user.visited_countries).sort{|x,y| x <=> y }
    
    @countries = country_object_list(Country.all.collect {|c| c[0]})
    @list = params['list'] || 'all'
    @countries = country_object_list(current_user.visited_countries) if @list=='visited'
    @countries = country_object_list(@unvisits) if @list=='unvisited'
    @countries = @countries.sort!{|x,y| x.name <=> y.name }  
  end
  
  def sort_country
    @countries = country_object_list(Country.all.collect {|c| c[0]})
    @list = params['list'] || 'all'
    @countries = country_object_list(current_user.visited_countries) if @list=='visited'
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
      array.each do |name|
        countries << Country.find_country_by_name(name)
      end
      countries
    end
end
