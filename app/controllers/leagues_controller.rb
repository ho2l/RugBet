class LeaguesController < ApplicationController
  before_filter :authenticate_user!, only:[:index,:new,:show,:edit,:create,:update,:destroy]
  before_action :set_league, only: [:show, :edit, :update, :destroy]


  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
    @leagues_user = League.find_by_sql("SELECT l.id, l.title FROM leagues l JOIN leagues_users lu ON l.id=lu.league_id WHERE lu.user_id="+current_user.id.to_s+";")
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @users = User.find_by_sql("SELECT u.username FROM users u JOIN leagues_users lu ON u.id=lu.user_id WHERE lu.league_id="+@league.id.to_s+";")
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  def join
    @pass = params[:pass] if params[:pass].present?
    @result = nil
    if (League.where(pass: @pass.to_i).take != nil)
      @league = League.where(pass: @pass.to_i).take
      if (League.count_by_sql("SELECT COUNT(*) FROM leagues_users WHERE league_id="+@league.id.to_s+" AND user_id="+current_user.id.to_s+";") != 0)
        @result = "Already in League !"
      else
        @query = "INSERT INTO leagues_users (league_id, user_id) VALUES ("+@league.id.to_s+","+current_user.id.to_s+");"
        League.connection.insert(@query)
        @result = "League joined !"
      end
    else
      if params[:pass].present?
        @result = "Wrong pass !"
      else
        @result = nil
      end
    end
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)
    @user = current_user
    @league.users << @user
    @league.pass = 0
    while ((@league.pass == 0) || (League.find_by pass: @league.pass != nil))
      @league.pass = Random.rand(999999)
    end

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url, notice: 'League was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:title, :description)
    end
end
