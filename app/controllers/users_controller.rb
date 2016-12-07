class UsersController < ApplicationController
  def index
    @totalpage = ( User.count / 10.0 ).ceil
    @page = params[:page].to_i || 1
    if @page > @totalpage
      @page = 1
    end
    if @page < 1
      @page = 1
    end
    @users = User.by_total_points.page(@page)

  end
end
