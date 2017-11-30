class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    
    @issues_and_types = Item.issues_and_types
    @selected_issues = params[:issues] || session[:issues] || {}
    sort_by = params[:sort_by] || session[:sort_by]
    search_term = params[:search] || session[:search]
    
    # if params[:sort_by] != session[:sort_by] || params[:search] != session[:search] || params[:issues] != session[:issues]
    #   session[:sort_by] = sort_by
    #   session[:search] = search_term
    #   session[:issues] = @selected_issues
    #   redirect_to(items_path(sort_by: sort_by, search: search_term, issues: @selected_issues)) && return
    # end

    # case sort_by
    #   when 'client_ssn'
    #     ordering = 'client_ssn'
    #   when 'client_name'
    #     ordering = 'client_name'
    # end

    ordering = sort_by

    if !search_term.nil?
      @items = Item.where('client_name like ? OR client_ssn like ? OR case_id like ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").order(ordering)
      @old_items = Item.where('(client_name like ? OR client_ssn like ? OR case_id like ?) AND date_opened < ?', "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", 90.days.ago)
    else
      @items = Item.order(ordering)
      @old_items = Item.where('date_opened < ?', 90.days.ago)
    end

    @items_alert_message = ''
    unless @old_items.empty?
      @items_alert_message = 'Case has been open for 90 days: '
      @old_items.each do |item|
        @items_alert_message += item[:client_ssn] + ', '
      end
    end
  end
    
  # GET /items/1
  # GET /items/1.json
  def show;
    @date_opened_string = "N/A"
    @date_closed_string = "N/A"

    if(@item.date_opened != nil)
      @date_opened_string = format('%04d', @item[:date_opened].year) + "-" + format('%02d', @item[:date_opened].month) + "-" + format('%02d', @item[:date_opened].day)
    end
    if(@item.date_closed != nil)
      @date_closed_string = format('%04d', @item[:date_closed].year) + "-" + format('%02d', @item[:date_closed].month) + "-" + format('%02d', @item[:date_closed].day)
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find params[:id]
  end

  # POST /items
  # POST /items.json
  def create
    if (item_params[:client_name] == "" && item_params[:client_ssn] == "")
      respond_to do |format|
        format.html {redirect_to items_url, notice: 'Error: At least client name or SSN must be entered to create a case.  Hit the BACK button to resume editing.'}
        format.json {head :no_content}
      end
      return
    end
    @item = Item.create!(item_params)
    tempCaseIdBase = format('%04d', @item[:date_opened].year) + format('%02d', @item[:date_opened].month) + format('%02d', @item[:date_opened].day)
    idNum = if Setting.get_all.key?(tempCaseIdBase)
              Setting[tempCaseIdBase] + 1
            else
              0
            end
    Setting[tempCaseIdBase] = idNum

    tempCaseId = tempCaseIdBase + format('%03d', idNum)
    @item.update_attributes(case_id: tempCaseId)
    # flash[:notice] = 'Item was successfully created.' + @item[:date_opened].year.to_s
    redirect_to items_path
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html {redirect_to items_path, notice: 'Item was successfully updated.'}
        format.json {render :show, status: :ok, location: @item}
      else
        format.html {render :edit}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html {redirect_to items_url, notice: 'Item was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :client_name,
      :client_ssn,
      :date_opened,
      :date_closed,
      Item.all_fields)
  end
end
