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
        formahtml {redirect_to items_url, notice: 'Error: At least client name or SSN must be entered to create a case.  Hit the BACK button to resume editing.'}
        formajson {head :no_content}
      end
      return
    end
    item_params[:document1]
    @item = Item.create(item_params)
    if !@item.valid?
      errStr = ""
      @item.errors.full_messages.each do |errMsg|
        errStr += errMsg + ".  "
      end
      respond_to do |format|
        formahtml {redirect_to items_url, notice: 'Error: ' + errStr}
        formajson {head :no_content}
      end
      return
    end
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
        @item.document1.destroy if params[:remove_document1] == "1"
        @item.document2.destroy if params[:remove_document2] == "1"
        @item.document3.destroy if params[:remove_document3] == "1"
        @item.document4.destroy if params[:remove_document4] == "1"
        @item.document5.destroy if params[:remove_document5] == "1"
        formahtml {redirect_to items_path, notice: 'Item was successfully updated.'}
        formajson {render :show, status: :ok, location: @item}
      else
        formahtml {render :edit}
        formajson {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      formahtml {redirect_to items_url, notice: 'Item was successfully destroyed.'}
      formajson {head :no_content}
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
      "document1_file_name",
      "document1_content_type",
      "document1_file_size",
      "document1_updated_at",
      "document2_file_name",
      "document2_content_type",
      "document2_file_size",
      "document2_updated_at",
      "document3_file_name",
      "document3_content_type",
      "document3_file_size",
      "document3_updated_at",
      "document4_file_name",
      "document4_content_type",
      "document4_file_size",
      "document4_updated_at",
      "document5_file_name",
      "document5_content_type",
      "document5_file_size",
      "document5_updated_at",
      "B_1",
      "B_2",
      "B_3",
      "B_4",
      "B_5",
      "B_6",
      "B_7",
      "B_8",
      "B_9",
      "B_10",
      "B_11",
      "B_12",
      "B_13",
      "B_14",
      "B_15",
      "B_16",
      "B_17",
      "B_18",
      "B_19",
      "B_20",
      "B_21",
      "B_22",
      "B_23",
      "B_24",
      "B_25",
      "B_26",
      "B_27",
      "B_28",
      "B_29",
      "B_30",
      "B_31",
      "B_32",
      "B_33",
      "B_34",
      "B_35",
      "B_36",
      "B_37",
      "B_38",
      "B_39",
      "B_40",
      "B_41",
      "B_42",
      "B_43",
      "B_44",
      "B_45",
      "B_46",
      "B_47",
      "B_48",
      "B_49",
      "B_50",
      "B_51",
      "B_52",
      "B_53",
      "B_54",
      "B_55",
      "B_56",
      "B_57",
      "B_58",
      "B_59",
      "B_60",
      "B_61",
      "B_62",
      "B_total",
      "K_1A",
      "K_1B",
      "K_1C",
      "K_1D",
      "K_1E",
      "K_2A",
      "K_2B",
      "K_2C",
      "K_2D",
      "K_2E",
      "K_2F",
      "K_2G",
      "K_2H",
      "K_2I",
      "K_2J",
      "K_2K",
      "K_2L",
      "K_2M",
      "K_2N",
      "K_2O",
      "K_2P",
      "K_2Q",
      "K_2R",
      "K_2S",
      "K_2T",
      "K_2U",
      "K_2V",
      "K_2W",
      "K_2X",
      "K_2Y",
      "K_2Z",
      "K_2AA",
      "K_T",
      "K_3",
      "K_4",
      "K_5",
      "K_6",
      "K_7",
      "K_8",
      "K_9",
      "K_10",
      "K_12",
      "K_13",
      "K_14",
      "K_15A",
      "K_15B",
      "K_15C",
      "K_15D"
      )
  end
end
